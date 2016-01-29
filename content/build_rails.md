+++
date = "2016-01-10T17:23:05+08:00"
draft = true
title = "build_rails"

+++

ch1

gem build rulers

cd rulers

vi rulers.gemspec

```ruby
     spec.add_runtime_dependency "rack"
```

gem build rulers.gemspec (is raise error 'contain itself ...' change version at 'lib/rulers/version.rb')

gem install rulers (install generated rulers-0.1.0.gem)

Then we can use the gem

create a dir for using rulers gem

mkdir best_quotes

vi Gemfile

```
    source 'https://rubygems.org'
    gem 'rulers'
```

bundle

bundle will use Gemfile as reference for install gems

vi config.ru # this is a file for rack xxx?

```
    run proc {
        [
              200, # status conde
              {''Content-Type' => 'text/html'}, #header
              ['HELLO WORLD !'] #content
         ]
     }
```

##header
“The important one for us right now is ‘Content-Type’, which must be ‘text/html’.  That just lets the browser know that we want the page rendered as HTML rather than text, JSON, XML, RSS or something else.”

# Then upgrade rullers
“Making Rulers Use Rack”

rackup -p 3001

this command will search config.ru

cd rulers

vi lib/rulers.rb

```ruby
require "rulers/version"

module Rulers
    class Application
        def call(env)
            [
                200,
                {'Content-Type' => 'text/html'},
                ['HELLO,WORLD!']
            ]
        end
    end
end
```

upgrade version to avoid 'contain itself error'

vi lib/rulers/version.rb

```
module Rulers
     VERSION = "0.1.1"
end
```

gem build rulers.gemspec
gem install rulers

cd best_quotes

bundle

vi config/application.rb

```ruby
require 'rulers'
module BestQuotes
    class Application < Rulers::Application

    end
end
```

vi config.ru

```
require './config/application' # imp!
run BestQuotes::Application.new # I do not know why this code work after moving some code to
#call(env) ... 
#WHY? see rack website
```

##rack
http://rack.github.io/

Rack provides a minimal interface between webservers that support Ruby and Ruby frameworks.

To use Rack, provide an "app": an object that responds to the call method, taking the environment hash as a parameter, and returning an Array with three elements:

The HTTP response code
A Hash of headers
The response body, which must respond to each

```
# my_rack_app.rb
 
require 'rack'
 
app = Proc.new do |env|
    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end
 
Rack::Handler::WEBrick.run app

```

Or

Or, you can use the rackup command line tool and avoid specifying details like port and server until runtime:

```

# config.ru
 run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
```

