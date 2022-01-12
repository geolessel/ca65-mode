# ca65-mode

An Emacs major mode for writing 6502 assembly code specifically for the
[ca65 assembler](https://cc65.github.io/doc/ca65.html).

## What does it do?

- Extremely strict indentation. Labels and any line that starts with a
  period (e.g. `.proc`, `.scope`) are on column 0. Everything else is
  indented to the column specified in the custom variable
  `ca65-mode-indent-width`. Why so strict? I don't know enough about
  writing major modes to ease the restriction and this is the
  indentation I currently prefer. Help me make it better!

- Syntax highlighting. I'm new to this to, but I have been able to get
  pleasing enough syntax highlighting for my tastes. I'm not sure if
  I'm doing it right, but it works!

## What does it not do (yet)?

I don't know how much it will do in the future, but it doesn't do any
sort of syntax checking or provide any special functions or commands
to run that may be helpful while writing 6502 assembly. Perhaps in the
future.

I am _very_ open to suggestions, ideas, and contributions, so pitch in!

## Resources

I found these articles and pages very helpful while researching how to
even create a major mode in the first place. If you want to write your
own major mode, hopefully these will help you, too. In no particular
order:

- https://www.reddit.com/r/emacs/comments/67o5fp/resources_for_developing_major_modes/
- https://www.wilfred.me.uk/blog/2015/03/19/adding-a-new-language-to-emacs/
- https://davidchristiansen.dk/2014/07/16/implementing-an-emacs-programming-language-mode-beyond-the-basics/
- https://www.omarpolo.com/post/writing-a-major-mode.html
- http://www.modernemacs.com/post/major-mode-part-1/
- https://emacs.stackexchange.com/questions/47276/emacs-custom-major-mode-with-multiple-comment-types
- https://www.reddit.com/r/emacs/comments/27wp98/getting_a_list_of_fontfaces/
- https://www.gnu.org/software/emacs/manual/html_node/elisp/Search_002dbased-Fontification.html
- https://www.gnu.org/software/emacs/manual/html_node/elisp/Auto_002dIndentation.html
