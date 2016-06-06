https://github.com/rails/rails/blob/master/actionpack/test/dispatch/mapper_test.rb



```ruby

resources :pages

constraints subdomain: 'api' do
  resources :posts
end

same as

resources :posts, constraints: { subdomain: 'api' }

url:
  api.domain/posts/
  domain/pages/
controller:
  PagesController
  PostsController
folder:
  /controllers/

---

Keeping our API under its own subdomain allows load balancing traffic at the DNS level. ???

resources :pages

constraints subdomaim: 'api' do
  namespace :api do
    resources :posts
  end
end

url:
  api.domain/api/posts/
  domain/pages/
controller:
  Api::PostsController
  PagesController
folder:
  /controllers/pages_controller.rb
  /controllers/api/posts_controller.rb

namespace: add URI prefix and controller namespace

---

resources :pages

constraints subdomain: 'api', path: '/' do
  namespace :api do
    resources :posts
  end
end

url:
  api.domain/posts/
  domain/pages/
controller:
  Api::PostsController
  PagesController
folder:
  /controllers/pages_controller.rb
  /controllers/api/posts_controller.rb

---

constraints subdomaim: 'api', path: '/' do
  namespace :api do
    resources :posts
  end
end

is same as

 do
  namespace :api, path: '/', constraints: { subdomaim: 'api' } do
    resources :posts
  end
end

---

namespace :api do
  resources :posts
end

url: api/posts/
controller: Api::PostsController

---

scope :api do
  resources :posts
end

same as

resources :articles, path: '/admin/articles'

url: posts/
controller: Api::PostsController

---

scope module :api do
  resources :posts
end

same as

resources posts, module: 'api'

url: api/posts/
controller: PostsController

```
