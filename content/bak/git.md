###wrong commit message?


##git clean -f
But beware... there's no going back. Use -n or --dry-run to preview the damage you'll do.

If you want to also remove directories, run git clean -f -d or git clean -fd

If you just want to remove ignored files, run git clean -f -X or git clean -fX

If you want to remove ignored as well as non-ignored files, run git clean -f -x or git clean -fx

Note the case difference on the X for the two latter commands.

If clean.requireForce is set to "true" (the default) in your configuration, then unless you specify -f nothing will actually happen.

See the git-clean docs for more information.


http://stackoverflow.com/questions/61212/how-do-i-remove-local-untracked-files-from-my-current-git-branch

##delete modified file

git reset --hard HEAD

http://stackoverflow.com/questions/8273823/how-can-i-discard-modified-files
