+++
date = "2015-12-01T11:47:13+08:00"
draft = true
title = "vim_note"

+++

# delete lines contain something

:{range}g /xxx/d

# substitute word within multiple file

:arg /sdf/sdf/*.*
:argdo %s/cmd/command/ge | update

r.f.
http://usevim.com/2012/04/06/search-and-replace-files/

