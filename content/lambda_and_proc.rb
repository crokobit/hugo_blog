def block_tester
  puts 'block tester'
  yield
  puts ''
end

def block_tester_call(&block)
  puts "block.class is #{block.class}"
  #puts "&block.class #{&block.class}"
  puts 'block tester call'
  block.call
  puts ''
end

block_tester do
  puts "block by do end"
end

block_tester_call do
  puts "block by do end"
end

proc_obj = Proc.new do
  puts "block by Proc"
end

block_tester(&proc_obj)
block_tester_call(&proc_obj)

proc_obj_defined_by_lambda = lambda do
  puts 'block by lambda'
end

block_tester(&proc_obj_defined_by_lambda)
block_tester_call(&proc_obj_defined_by_lambda)

# block_by_curly = { puts "block by curly" } can not

block_tester{ puts "block by curly" }
block_tester_call{ puts "block by curly" }

proc_obj_defined_by_lambda.class # => Proc
proc_obj.class # => Proc

# Proc.new == lambda, can parameterize
# {} == do ... end, only can be used by putting after the function
# &block for passing Block(Proc) into function
# yield = block.call
# proc is object. block( do..end, {}, &block) isn't. So block can not be assigned to variable.
# can only pass one block to function(syntax constraint), but can have multiple proc parameter.
# can pass parameter to yield or &block.call
# "code block has the scope where it is defined, it can use the variable can be found when defining itself"
# can use varaible excute the block and catch the return value for excute arround purpose.
# The whole idea of execute around is that the caller is guaranteed that this will happen before the code block fires and that will happen after.
# execute around make your code a bit easier to read. e.g. say_with_block{ "something" }

=begin
class Migration
  # Most of the class omitted...
  def say(message, subitem=false)
    write "#{subitem ? "   ->" : "--"} #{message}"
  end
  
  def say_with_time(message)
    say(message)
    result = nil
    time = Benchmark.measure { result = yield }
    say "%.4fs" % time.real, :subitem
    say("#{result} rows", :subitem) if result.is_a?(Integer)
    result
  end 
end
=end

# >> block tester
# >> block by do end
# >> 
# >> block.class is Proc
# >> block tester call
# >> block by do end
# >> 
# >> block tester
# >> block by Proc
# >> 
# >> block.class is Proc
# >> block tester call
# >> block by Proc
# >> 
# >> block tester
# >> block by lambda
# >> 
# >> block.class is Proc
# >> block tester call
# >> block by lambda
# >> 
# >> block tester
# >> block by curly
# >> 
# >> block.class is Proc
# >> block tester call
# >> block by curly
# >> 
