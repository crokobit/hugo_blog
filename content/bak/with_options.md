##with_options

```ruby
with_options { default_options } do |association|
  association.xxx ...
end
```

merge xxx's options with default_options

##option_merger

merge method's option

```ruby
require 'active_support/core_ext/hash/deep_merge'

module ActiveSupport
  class OptionMerger #:nodoc:
    instance_methods.each do |method|
      undef_method(method) if method !~ /^(__|instance_eval|class|object_id)/
    end

    def initialize(context, options)
      @context, @options = context, options
    end

    private
      def method_missing(method, *arguments, &block)
        if arguments.first.is_a?(Proc)
          proc = arguments.pop
          arguments << lambda { |*args| @options.deep_merge(proc.call(*args)) }
        else
          arguments << (arguments.last.respond_to?(:to_hash) ? @options.deep_merge(arguments.pop) : @options.dup)
        end

        @context.__send__(method, *arguments, &block)
      end
  end
end
```

###undef_method(mehtod)

prevent any call of method

###!~(regexp)

```
!~(regexp)
Equivalent to String#!~. Match the class name against the given regexp. Returns true if there is no match, otherwise false
```

###__send__(method, *arguments, &block)

invoke method with arguments and proc

r.f.

with_options
https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/object/with_options.rb

option_merger
https://github.com/rails/rails/blob/master/activesupport/lib/active_support/option_merger.rb

option_merger_test
https://github.com/rails/rails/blob/master/activesupport/test/option_merger_test.rb
