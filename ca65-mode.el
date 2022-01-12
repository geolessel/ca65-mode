;;; ca65-asm-mode --- major mode for 6502 assembly with ca65 assembler

;; Copyright (c) 2022 Geoffrey Lessel
;; Author: Geoffrey Lessel <code@geoffreylessel.com>
;; Version: 0.1
;; Keywords: languages, 6502, ca65
;; URL: https://github.com/geolessel/ca65-mode

;;; Commentary:
;; Provides a major mode for editing 6502 assembly code. Specifically,
;; 6502 assembly code that will use the ca65 assembler.

;;; Code:

(defgroup ca65 nil
  "Major mode for editing 6502 assembly (targeting the ca65 assembler)"
  :prefix "ca65-"
  :group 'languages)
(defcustom ca65-mode-indent-width
  4
  "Width of indentation."
  :group 'ca65
  :type '(integer))

(defvar ca65-mode-font-lock)
(setq ca65-mode-font-lock
      ;; ordering important here as it seems to stop matching once it finds one
      '(
        ;; constants (e.g. `TEMP = $0200`)
        ("\\([a-zA-Z_]+\\)[[:blank:]]*=" 1 font-lock-constant-face)
        ;; addressing
        (" +\\([$%#]+\\)" . font-lock-builtin-face)

        ;; opcodes with constants
        ("[ :]+\\([a-zA-Z]+\\) +\\([a-zA-Z]+\\)"
         (1 font-lock-function-name-face)
         (2 font-lock-constant-face))
        ;; other opcodes
        ("[ :]+\\([a-zA-Z]+\\)\\b" . font-lock-function-name-face)

        ;; labels
        ("^\\([a-zA-Z_]+:\\)" . font-lock-type-face)
        ;; assembler directives
        ("^\\(\\.[a-zA-Z_][a-zA-Z0-9_]*\\)\\b" . font-lock-preprocessor-face)
        "Things to highlight in ca65-mode."))

(defconst ca65-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; " is a string delimiter
    (modify-syntax-entry ?\" "\"" table)
    ;; ; is a comment starter
    (modify-syntax-entry ?\; "<" table)
    ;; \n is a comment ender
    (modify-syntax-entry ?\n ">" table)
    ;; ' is a character quote
    (modify-syntax-entry ?' "/" table)
    table))

;; Indentation

(defun ca65-mode--current-line-empty-p ()
  "Check if the current line is empty."
  (save-excursion
    (beginning-of-line)
    (looking-at-p "[[:blank:]]*$")))

(defun ca65-mode-indent-line ()
  "Indentation logic for ca65-mode."
  (interactive)

  (let ((indent 1))
    (save-excursion
      (back-to-indentation)

      ;; if the line starts with a period, indent 0
      (when (eq (char-after) ?.)
        (setq indent 0))

      ;; if the line is a label (first word ends with colon), indent 0
      (save-excursion
        (forward-word)
        (when (eq (char-after) ?:)
          (setq indent 0)))

      ;; delete the beginning of the line to reset indentation
      (delete-region (line-beginning-position) (point))
      ;; perform the indentation
      (indent-to (* indent ca65-mode-indent-width)))
    (when (ca65-mode--current-line-empty-p)
      (move-end-of-line nil))))

(define-derived-mode
  ca65-mode
  prog-mode
  "ca65"
  "Mode for editing 6502 assembly with the ca65 assembler."

  :syntax-table ca65-mode-syntax-table

  (set (make-local-variable 'font-lock-defaults)
       '(ca65-mode-font-lock))
  (font-lock-ensure)

  (setq-local indent-line-function #'ca65-mode-indent-line)
  (setq major-mode 'ca65-mode))

(provide 'ca65-mode)
;;; ca65-mode.el ends here
