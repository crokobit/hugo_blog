+++
date = "2015-12-28T14:53:50+08:00"
draft = true
title = "include_and_extend_for_ruby"

+++
# include

- include module methods as instance methods

# extend

- extend module instance methods as class methods

# actions when included or extended

- class method 'self.included' is the action when include the module
- class method 'self.extended' is the action when extend the module
- base is the host class including / extending the module
- use `base.include`, `base.extend` to do some action to the host class

```ruby
self.included(base)
end
```

# ActiveSupport::Concern 

- solves the module dependency problem

If  module B need need A, class C needs to include both module A and B. ActiveSupport::Concern solve this.

```ruby
  module A
    def self.included(base)
      base.send(:include, XXX)
    end
  end

  module B
    # depends on A
  end

  class C
    include A
    include B 
  end
```

```ruby
  module A
    # base become B, wrong!
    def self.included(base)
      base.send(:include, XXX)
    end
  end

  module B
    include A
  end

  class C
    include A
    include B 
  end
```
```ruby
  module A
    def self.included(base)
      base.send(:include, XXX)
    end
  end

  module B
    extend ActiveSupport::Concern
    included do
      self.send(:do_sth)
    end
  end

  class C
    include B 
  end
```

- auto include

```ruby
  module Set
    extend ActiveSupport::Concern
    module ClassMethods
      def a
        puts 'a'
      end
    end
    module InstanceMethods
      def b
        puts 'b'
      end
    end
  end

  class Host
    include Set
  end

  Host.a => a
  Host.new.b => b

```

r.f.

https://ihower.tw/blog/archives/3949
http://github.com/rails/rails/blob/master/activesupport/lib/active_support/concern.rb
