+++
date = "2015-11-28T21:43:11+08:00"
draft = false
title = "hugo_wercker_set_up"

+++

It sucks....

# config.toml
```yml
baseurl = "http://crokobit.github.io/"
languageCode = "en-us"
title = "Wanderer"
```
# wercker.yml
```yml
box: debian
build:
  steps:
    - arjen/hugo-build:
      version: "0.14"
      theme: detox
      flags: --buildDrafts=true
deploy:
  steps:
    - install-packages:
      packages: git ssh-client
    - lukevivier/gh-pages@0.2.1:
      token: $GIT_TOKEN
      repo: crokobit/crokobit.github.io
      branch: master
      basedir: public
```

notice should have repository user/user.github.io

# add syntax highlighting
ohttps://gohugo.io/extras/highlighting/

use Highlight.js

copy the Highlight.js example below three lines to ./layouts/partials/header.html . It not existed yet! Created it!

```html
<link rel="stylesheet" href="https://yandex.st/highlightjs/8.0/styles/default.min.css">
<script src="https://yandex.st/highlightjs/8.0/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
```

include different Highlight.js to get different style.


# themes
o
add you theme (detox here) to git, push it.
need have at least one content.

submodule
http://www.minute.no/2015/04/setting-up-a-git-repository-with-nested-submodules/

even already add a submodule, still need to commit it into main git repository. Otherwise, it will generate blank blog. 
https://discuss.gohugo.io/t/themes-dont-carry-over-on-github-hosting/1098/4

# deploy without wercker
https://blog.carl.tw/2015/04/06/hello-hugo/

#run locally
hugo server --theme=hyde --buildDrafts
