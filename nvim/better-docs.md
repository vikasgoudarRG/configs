# plugins

## auto-session.lua

> auto load session in cwd if exists
> if nvim <somefile> or nvim <multiple files>, auto session wont do anything
> auto save session when close
> [default changed] dont create session when close if not exists
> `TODO:` not really sure about this behaviour
> do :qa because otherwise if you do :q for each pane, it will kill the session

### keybinds

- <leader>wf -> session search ui
  - <C-d> -> delete highlighted session
- <leader>ws -> session save
- <leader>wr -> session restore
- <leader>wd -> session delete

## telescope.lua

### keybinds

> telescope.lua

- <leader>pf -> telescope find files
- <leader>pgf -> telescope find git files
- <leader>pcf -> telescope find config files
- <leader>plg -> telescope find live grep
- <leader>psg -> telescope find string grep (string under cursor or selection)
- <leader>ths -> theme switch

## todo-comments.lua

### keybinds

- <leader>pt -> telescope find todo-comments

## formatting.lua

> formats on save
> but can also manually format in 'v', 'n' using
>
> > <leader>mp -> make pretty

## git.lua

### lazygit

#### keybinds

- <leader>gg -> lazygit ui

### gitsigns

> attaches to only tracked files

#### keybinds

- <leader>]h -> next hunk
- <leader>[h -> prev hunk
- <leader>hs -> stage hunk
- <leader>hb -> window hunk blame
- <leader>hs -> stage hunk selection
- <leader>hr -> reset hunk selection
- <leader>hS -> stage buffer
- <leader>hR -> reset buffer
- <leader>hp -> preview hunk (to see old)
- <leader>hi -> preview hunk inline (to see old)
- <leader>hd -> difference since stage
- <leader>hD -> difference since commit
- <leader>hq -> find every single hunk in the file
- <leader>hQ -> finds every hunk in the Git repo
- ih -> recognizes hunk as a text object, so can use in motions like diw, yiw, vih...

TODO: n, x and so on
