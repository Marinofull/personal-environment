My Personal Environment Files
====================

This repo intends to provide my personal environment. It consists in a git repo with submodules, which ones are dependencies.
The environment is builded by `install.rb` which set symlinks to .files inside this repo and storage older .files whether overwritten.

To configure types:
`$ ruby install.rb`

Open the `.gitconfig` and `.aliases/bash-functions` and change your github user and e-mail.


Plugins
-------

- [powerline](http://www.tecmint.com/powerline-adds-powerful-statuslines-and-prompts-to-vim-and-bash/)

#### Vim Plugins

- Emmet-vim:
    - Expand an Abbreviation. Type the abbreviation as `div>p#foo$*3>a` and type `<c-e>,`;
```html
    <div>
        <p id="foo1">
            <a href=""></a>
        </p>
        <p id="foo2">
            <a href=""></a>
        </p>
        <p id="foo3">
            <a href=""></a>
        </p>
    </div>
```
- To freaking comment.
  Move cursor to block
```html
  <div>
      hello world
  </div>
```
  Type `<C-y>/` in insert mode.
```html
  <!-- <div>
      hello world
  </div> -->
```
  Type `<C-y>/` in there again.
```html
  <div>
      hello world
  </div>
```

Hacks and Tricks
-------------

Informations
-------------

>
