# flow control
only false and nil are treated as false
the number 0, being neither false nor nil, is true in Ruby

#If, Unless, While, and Until
if not ... (bad)
unless (good)

```ruby
while ! document.is_printed?
  document.print_next_page
end
```

equal

```ruby
until document.printed?
  document.print_next_page
end
```

better

```ruby
document.print_next_page while document.pages_available?
document.print_next_page until document.printed?
```

#use each, not for
for font in fonts

end

fonts.each do |font|

end

```ruby
fonts = [ 'courier', 'times roman', 'helvetica' ] # => ["courier", "times roman", "helvetica"]
for font in fonts # => ["courier", "times roman", "helvetica"]
  a = 3
end # => ["courier", "times roman", "helvetica"]

a # => 3

fonts.each do |font|
  b = 4
end

b # =>

# ~> NameError
# ~> undefined local variable or method `b' for main:Object
# ~>
# ~> /var/folders/z4/d6t82x0n0k5_36t11tfgrnxh0000gn/T/seeing_is_believing_temp_dir20141025-75598-1x7urza/program.rb:12:in `<main>'
```
`do ... end` `{ ... }` introduce a new scope. for ...in ... end doesn't

#case

```ruby
case title
when "A"
  #do sth
when "B"
  #do sth
else
  #do sth
end
```

```ruby
case title
when "A" then ...
end
```

may return nil is no "else"
compare by "===" operator
can use to assign value(you can take advantage of the expression-oriented nature of Ruby to pull values back from a case statement.)
can use a case statement to switch on the class of an object


avoid testing for truth by testing for specific values.
because in ruby, sometimes function not returns true or false, but returns extra information or nil.

If you are looking for nil and there is any possibility of false turning up, then look for nil explicitly.
e.g.
```ruby
# Broken in a subtle way...
while next_object = get_next_object
  # Do something with the object
end
```

```ruby
until (next_object = get_next_object).nil?
  # Do something with the object
end
```

A familiar initialization problem: Sometimes you are just not sure if you need to initialize a variable. For exam- ple, you might want to ensure that an instance variable is not nil.

form
count = count + 1
count += 1

to
@first_name = @first_name || ''
@first_name ||= ''
bellow include partial function above, lacking self assigne (bad)
@first_name = '' unless @first_name

If @first_name happened to start out as false, the code would cheerfully go ahead and reset it to the empty string. Moral of the story: Don’t try to use ||= to initialize things to booleans.


#starred parameter
You can only have one starred parameter

```ruby
poem_words = %w{ twinkle little star how I wonder } # => ["twinkle", "little", "star", "how", "I", "wonder"]

def echo_at_least_two( first_arg, *middle_args, last_arg )
    puts "The first argument is #{first_arg}"
    middle_args.each { |arg|puts "A middle argument is #{arg}" }
    puts "The last argument is #{last_arg}"
end

echo_at_least_two("A","B","C","D") # => nil

# >> The first argument is A
# >> A middle argument is B
# >> A middle argument is C
# >> The last argument is D
```

Hash as final parameter have several adventage:
1. pass option parameter optionally
2. leave braces {} off when calling method
3. leave the parentheneses off

e.g.
def function(parameter, hash); end;

function(1 ,{key: value})
function(1, key: value)
function 1, key: value

#Hash each
same as .to_a.each
e.g.
```ruby
movie = { title: '2001', genre: 'sci fi', rating: 10 }
movie.to_a # => [[:title, "2001"], [:genre, "sci fi"], [:rating, 10]]
movie.each {|k,v| puts "key: #{k}, value: #{v}"} # => {:title=>"2001", :genre=>"sci fi", :rating=>10}

# >> key: title, value: 2001
# # >> key: genre, value: sci fi
# # >> key: rating, value: 10
```
#methods af array
find_index
inject(initialize value){|sun, value|}
map
```ruby
array = [1, 2, 3, 4]
array.inject(0) { |sum,value| sum + value } # => 10
array.find_index(3) # => 2
array.map{|value| "haa*#{value}"} # => ["haa*1", "haa*2", "haa*3", "haa*4"]
```

http://ruby-doc.org/core-2.1.5/Enumerable.html
all?
any?
http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
html_safe
http://guides.rubyonrails.org/form_helpers.html
add helper in reform
http://stackoverflow.com/questions/6853015/how-do-i-use-an-actionviewhelper-in-a-ruby-script-outside-of-rails
I18n l function
http://api.rubyonrails.org/classes/ActionView/Helpers/TranslationHelper.html#method-i-t
http://guides.rubyonrails.org/i18n.html
recurive set dir
http://stackoverflow.com/questions/19280341/create-directory-if-it-doesnt-exist-with-ruby
http://ruby-doc.org/stdlib-1.9.3/libdoc/fileutils/rdoc/FileUtils.html#method-c-mkdir
codemetrix syntax code style check
https://www.ruby-toolbox.com/categories/code_metrics
ssh “permissions are too open” error
chmod 400 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
http://stackoverflow.com/questions/9270734/ssh-permissions-are-too-open-error
string convert
http://stackoverflow.com/questions/2004491/convert-string-to-symbol-able-in-ruby
http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore
value precision and adapter
http://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html#method-i-number_with_delimiter

http://www.ruby-doc.org/core-2.1.5/Array.html#method-i-delete_if
http://ruby-doc.org/core-2.1.5/Enumerable.html
n = Notification::Answer.new
# => "Answer"
# n.class.name.demodulize
# File.dirname("C:/Test/blah.txt")
# # => "C:/Test"
#
How to store files out side the public folder in carrierwave?
http://stackoverflow.com/questions/5979096/how-to-store-files-out-side-the-public-folder-in-carrierwave
CarrierWave.configure do |config|
  config.root = Rails.root
end

Attempted to update a stale object:

http://www.ruby-doc.org/core-2.1.5/Array.html#method-i-fetch
access array with default behavior



```ruby
array = [1, 2, 3, 4]
array.inject(0) { |sum,value| sum + value } # => 10
array.reduce(0, :+)
array.inject(:+)
arrat.reduce(:+)

array.find_index(3) # => 2
array.map{|value| "haa*#{value}"} # => ["haa*1", "haa*2", "haa*3", "haa*4"]
```

def flatten(array)
  array.inject([]) { |result, elem| result + (elem.is_a?(Array) ? elem : [elem]) }
end

hash.inject({}) { |hash,(k,v)| hash[k.to_s] = v; hash }

String.scan
scan substring or regexp, return substring array

String.match
match hole string, return group array

regexp escape
input /.../
escape / adding \ become  \/

Array.combination(n)
array combination of n element

flat_map() public
Returns a new array with the concatenated results of running block once for every element in enum.

Iterates the given block for each element with an arbitrary object given, and returns the initially given object.

If no block is given, returns an enumerator.

evens = (1..10).each_with_object([]) { |i, a| a << i*2 }


ceil → integer click to toggle source
Returns the smallest Integer greater than or equal to float.

If you're using ruby 1.8.7 or 1.9, you can use the fact that iterator methods like each_with_index, when called without a block, return an Enumerator object, which you can call Enumerable methods like map on. So you can do:

arr.each_with_index.map { |x,i| [x, i+2] }

def all_squared_pairs(num)
 (0..Math.sqrt(num)).each_with_object([]) { |e, a|
   puts "e:#{e} a:#{a}"
   b = Math.sqrt(num - e**2)
   a << [e, b.to_i].sort if b.to_i == b
 }.uniq
end

all_squared_pairs(100)

# >> e:0 a:[]
# >> e:1 a:[[0, 10]]
# >> e:2 a:[[0, 10]]
# >> e:3 a:[[0, 10]]
# >> e:4 a:[[0, 10]]
# >> e:5 a:[[0, 10]]
# >> e:6 a:[[0, 10]]
# >> e:7 a:[[0, 10], [6, 8]]
# >> e:8 a:[[0, 10], [6, 8]]
# >> e:9 a:[[0, 10], [6, 8], [6, 8]]
# >> e:10 a:[[0, 10], [6, 8], [6, 8]]

easy for us to set class object's status!
http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html

Ruby for Newbies: Operators and their Methods

class Test
end

test= Test.new

test[:parameter] == test.[](:parameter)

size

will remember what value is previous query.


count

will query db every time.

length

xxx.policy_items.length

will load every policy_item to memory

Array
shift => extract object from first element of array
unshift => add object to first element of array
both change array value

class AboutArrayAssignment < EdgeCase::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal , names
  end


  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]
    assert_equal , first_name
    assert_equal , last_name
  end


  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal , first_name
    assert_equal , last_name
  end


  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal , first_name
    assert_equal , last_name
  end


  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    assert_equal , first_name
    assert_equal , last_name
  end


  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal , first_name
    assert_equal , last_name
  end


  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"]
    assert_equal , first_name
  end


  Please meditate on the following.
  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal , first_name
    assert_equal , last_name
  end

hash will reture nil if reference it by key it do not have

hash.keys
hash.values

string
"" or '' use \ to escape " or '  

def test_use_flexible_quoting_to_handle_really_hard_cases
   a = %(flexible quotes can handle both ' and " characters)
   b = %!flexible quotes can handle both ' and " characters!
   c = %{flexible quotes can handle both ' and " characters}
   assert_equal , a == b
   assert_equal , a == c
end

def test_here_documents_can_also_handle_multiple_lines
  long_string = << EOS
    It was the best of times,
    It was the worst of times.
  EOS
  assert_equal , long_string.size
end

##THIS IS AMAZING!
  def test_the_shovel_operator_modifies_the_original_string
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi << there
    assert_equal , original_string

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
  end

  def test_double_quoted_string_interpret_escape_characters
    string = "\n"
    assert_equal , string.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    string = '\n'
    assert_equal , string.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    string = '\\\''
    assert_equal , string.size
    assert_equal , string
  end

  def test_you_can_get_a_substring_from_a_string
    string = "Bacon, lettuce and tomato"
    assert_equal , string[7,3]
    assert_equal , string[7..9]
  end

## WHY?

  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
    assert_equal , symbols_as_strings.include?("test_method_names_become_symbols")
  end


  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal symbol, .to_sym
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal symbol, .to_sym
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal , string
  end

eql? compare equal?

respond_to? determine object respond to it or not

.methods.include? ...

class TestClass
  def method1
  end

  def method2
  end

  def method3
  end
end

TestClass.methods.grep(/method1/) # => []
TestClass.instance_methods.grep(/method1/) # => ["method1"]
TestClass.methods.grep(/new/) # => ["new"]
Or you can call methods (not instance_methods) on the object:

test_object = TestClass.new
test_object.methods.grep(/method1/) # => ["method1"]

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal , symbol.respond_to?(:each_char)
    assert_equal , symbol.respond_to?(:reverse)
  end


  # It's important to realize that symbols are not "immutable
  # strings", though they are immutable. None of the
  # interesting string operations are available on symbols.

##Regexp

"some matching content"[/match/]
\s => \t \n whitespace

  def test_slash_w_is_a_shortcut_for_a_word_character_class
    # NOTE:  This is more like how a programmer might define a word.
    assert_equal , "variable_1 = 42"[/[a-zA-Z0-9_]+/]
    assert_equal , "variable_1 = 42"[/\w+/]
  end

  def test_period_is_a_shortcut_for_any_non_newline_character
    assert_equal , "abc\n123"[/a.+/]
  end

  def test_a_character_class_can_be_negated
    assert_equal , "the number is 42"[/[^0-9]+/]
  end

  def test_shortcut_character_classes_are_negated_with_capitals
    assert_equal , "the number is 42"[/\D+/]
    assert_equal , "space: \t\n"[/\S+/]
    assert_equal , "variable_1 = 42"[/\W+/]
  end

  def test_slash_a_anchors_to_the_start_of_the_string
    assert_equal , "start end"[/\Astart/]
    assert_equal , "start end"[/\Aend/]
  end


  def test_slash_z_anchors_to_the_end_of_the_string
    assert_equal , "start end"[/end\z/]
    assert_equal , "start end"[/start\z/]
  end

  def test_caret_anchors_to_the_start_of_lines
    assert_equal , "num 42\n2 lines"[/^\d+/]
  end

  def test_dollar_sign_anchors_to_the_end_of_lines
    assert_equal , "2 lines\nnum 42"[/\d+$/]
  end

  def test_slash_b_anchors_to_a_word_boundary
    assert_equal , "bovine vines"[/\bvine./]
  end

  def test_parentheses_group_contents
    assert_equal , "ahahaha"[/(ha)+/]
  end

  def test_parentheses_also_capture_matched_content_by_number
    assert_equal , "Gray, James"[/(\w+), (\w+)/, 1]
    assert_equal , "Gray, James"[/(\w+), (\w+)/, 2]
  end

##WHAT IS $ ???!!
  def test_variables_can_also_be_used_to_access_captures
    assert_equal , "Name:  Gray, James"[/(\w+), (\w+)/]
    assert_equal , $1
    assert_equal , $2
  end


  def test_a_vertical_pipe_means_or
    grays = /(James|Dana|Summer) Gray/
    assert_equal , "James Gray"[grays]
    assert_equal , "Summer Gray"[grays, 1]
    assert_equal , "Jim Gray"[grays, 1]
  end


"one two-three".sub(/(t\w*)/) { $1 }
"string".sub(/Regexp/) { sub what }


$1  == Previous Regexp get group 1
$2  == Previous Regexp get group 2


  def test_sub_is_like_find_and_replace
    assert_equal , "one two-three".sub(/(t\w*)/) { $1[0, 1] }
  end


  Please meditate on the following.
  def test_gsub_is_like_find_and_replace_all
    assert_equal , "one two-three".gsub(/(t\w*)/) { $1[0, 1] }
  end

## ActiveSupport
''.in? [...]
