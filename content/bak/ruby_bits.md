#Your own each

# || ||=

raise XxxException, "message"

```ruby
begin
  # code were need to deal with exception 
rescue XxxxException
  p 'rescue XxxxException exception and raise new ones(return where raise error)'
ensure
  p 'code here will be execute nomater raise error or not'
end

# >> "rescue all exception and raise new ones"
# >> "code here will be execute nomater raise error or not"
```
#Rescuing Exceptions Inside Methods

```ruby
def function
rescue
end
```

#overwrite

to_s
each (can include EmuxXX)
overwrite function with same name of ancestor function


#ENCAPSULATION
• Passing around data(e.g. user_id) as strings and numbers breaks encapsulation.
• Places using that data need to know how to handle it.(e.g. fetch user , not suitable if pass user_id and call another function to fetch user)
• Individual changes require updates at various places.
When you have behavior to go with the data, it is time to introduce a class.
(encapsulation)
TO SUMMARY:
Data with specific actiton need create a class to handle it. Thus not violating encapsulation.

#visibility

instance from same class can access, outside class (or instance of same class outside class)can not access => protected
instance from same class can not access, outside class (or instance of same class outside class)can not access => private

#super
initialize
call super (ancesor same name class!!)
call it on the end? convension? 
call "super" same as super(parameter) if that function have parameter

#yield
pass a block to function as a parameter, use it in function as 'yield'
can pass parameter to the 'yield', reference the pass parameter by |parameter| in block, only orfer matters.
```ruby
def function
  yield "parameter1", {a:1, b:2}
end

function do |p,q|
  puts p
  puts q[a:]
end
```

#attr_...
attr_accessor
attr_reader
attr_writer
autogenerate getter and setter and a instance variable!
```ruby
require 'pry'
class Car 
  attr_accessor :name
  def initialize
    @name = "car name"
  end 
  def test
    yield "Haaaa", {a:1, b:2}
  end 

  def car_name
    puts @name.object_id 
    puts self.name.object_id
  end 
end

toyota = Car.new
toyota.name # => "car name"
toyota.car_name # => nil

# >> 70280195911000
# >> 70280195911000
```

lambda can have parameter!!

Proc.new = lambda

block -> yield
lambda -> xxx.call , can pass as parameter
lambda to block -> &lanbda
block pass into function as proc
```ruby
def function(&proc_parameter)
  #proc_parameter now is block transed to proc
  # &proc_parameter <- trans back to block !! for not using yield
end
```
??????

class Library
  attr_accessor :games
  [:each, :map, :select].each do |ss|
    define_method(ss) do |&_proc|
      games.send(ss, &_proc)
    end
  end
end

http://ruby-doc.org/core-1.9.3/Module.html#method-i-define_method


???

http://hashrocket.com/blog/posts/using-simpledelegator-for-your-decorators

Call the SimpleDelegator 'initialize' method, passing the object it should delegate to.
```ruby
require 'delegate'

class Library < SimpleDelegator
  def initialize(console)
    super(console)
  end
end
```
