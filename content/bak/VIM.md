#vim
## cw
delete character from cursor to end without space inside word now. Then, into insert mode
## dw
delete character from cursor to end with space inside word now. Then, into insert mode
##dot command .
1. memory previous command in normal mode
2. memory successive keys between into insert mode(I i A a ...) and out

##Two for the price of one
| Compound Command | Equivalent in Longhand |
|:-:|:-:|:-:|
|C|c$|
|s|cl|
|S|^C ddOi|
|I|^i|
|A|$a|
|o|A<CR>|
|O|ko k$a<CR>|

##find
###f{char}
####; next
####, previous

##find
###/pattern<CR> ?pattern<CR> 
####n next
####N previous

##@: 
can be used to repeat any Ex command

##*
This executes a search for the word under the cursor at that moment

##Find and Replace by Hand
chage same name... do not use <c,n>ii (plugin)
use /{old} * cw{new} * . *

command: :substitude

```
:%s/foo/bar/g
Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.
:s/foo/bar/g
Find each occurrence of 'foo' (in the current line only), and replace it with 'bar'.
:%s/foo/bar/gc
Change each 'foo' to 'bar', but ask for confirmation first.
:%s/\<foo\>/bar/gc
Change only whole words exactly matching 'foo' to 'bar'; ask for confirmation.
```

g replace
c confirm

####confirm
When using the c flag, you need to confirm for each match what to do. Vim will output something like: replace with foobar (y/n/a/q/l/^E/^Y)? (where foobar is the replacement part of the :s/.../.../ command. You can type y which means to substitute this match, n to skip this match, a to substitute this and all remaining matches ("all" remaining matches), q to quit the command, l to substitute this match and quit (think of "last"), ^E to scroll the screen up by holding the Ctrl key and pressing E and ^Y to scroll the screen down by holding the Ctrl key and pressing Y. 

###http://vim.wikia.com/wiki/Search_and_replace

##The Ideal: One Keystroke to Move, One Keystroke to Execut
We’ll see this editing strategy coming up again and again, so for the sake of convenience, we’ll refer to this pattern as the Dot Formula.

## d delete
d{arrow command}
dw cusor to end
db cusor to word head
daw around word?? with a white space deleted
diw inside word??

## c change

## {num}<C-a> {num}<C-x>
add or substract number to closet foward word by {num}

treet 0XX as octal
can set it to decimal by
```
set nrformats=
This will cause Vim to treat all numerals as decimal, regardless of whether they are padded with zeros.
```

p.47
