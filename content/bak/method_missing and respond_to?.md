method_missing and respond_to?

r.f.
http://technicalpickles.com/posts/using-method_missing-and-respond_to-to-create-dynamic-methods/

Using it when we wants to create dynamic methods

### method_missing

Will call method_missing if can not find sended method in that object.
Use this when need to create methods by attribute name or attribute values...
It is called 'metaprogramming'.

```ruby
  class Object

    def self.method_missing(method_sym, *arguments, &block)
      if method_sym =~ /^find_by_(.)$/
        find($1.to_sym => arguments.first)
      else
        super
      end
    end

  end
```

### respond_to?

check whether this object is respond to the message or not
if metaprogramming technique.we also need implement respond_to? too.

## DRY

The logic decided whether method name match what we expect for metaprogramming or not can be extracted to a class.

```ruby
  class FinderMatcher
    attr_accessor :attribute
    def initialize(method_name)
      method_name ~= /^find_by_(.)$/
      @attribute = $1
    end

    def match?
      attribute
    end
  end
```


ActiveRecord::DynamicFinderMatch is implementation of this pattern.
https://github.com/rails/rails/blob/3-2-stable/activerecord/lib/active_record/dynamic_finder_match.rb

New implementation (NO ActiveRecord::DynamicFinderMatch)
https://github.com/rails/rails/blob/master/activerecord/lib/active_record/dynamic_matchers.rb





###=~(regexp)

Equivalent to String#=~. Match the class name against the given regexp. Returns the position where the match starts or nil if there is no match.


###Caching method_missing

http://www.jroller.com/dscataglini/entry/speeding_up_method_missing

efficiency
regular expression < compare using == ...etc. < caching + inlining

caching : use

```ruby
class_eval <<-RUBY
  def self.#{finder}(#{attribute})        # def self.find_by_first_name(first_name)
    find(:#{attribute} => #{attribute})   #   find(:first_name => first_name)
  end                                     # end
RUBY
```  
