array = [1, 2, 3, 4]
array.inject(0) { |sum,value| sum + value } # => 10
array.find_index(3) # => 2
array.map{|value| "haa*#{value}"} # => ["haa*1", "haa*2", "haa*3", "haa*4"]

def capital(capitals_hash_array)  
  ans = []
  all_string_key_hash = []
  capitals_hash_array.each do |hash|
    all_string_key_hash << hash.inject({}) { |hash,(k,v)| hash[k.to_s] = v; hash }
  end
  all_string_key_hash.each do |hash|
    ans << ["The capital of #{hash["state"] || hash["country"]} is #{hash["capital"]}"]
  end
  ans
end

test_hash = [{"country"=>"Canada", "capital"=>"Ottawa"}, {"state"=>"Colorado", "capital"=>"Denver"}, {"country"=>"Iran", "capital"=>"Tehran"}]
capital(test_hash) # => [["The capital of Canada is Ottawa"], ["The capital of Colorado is Denver"], ["The capital of Iran is Tehran"]]

mixed_capitals = [{"state" => 'Maine', capital: 'Augusta'}, {country: 'Spain', "capital" => "Madrid"}]
capital(mixed_capitals) # => [["The capital of Maine is Augusta"], ["The capital of Spain is Madrid"]]

hash = {vovo: 1, soso: 2}
hash.fetch(:vovo)
hash.fetch(:soso)
hash.fetch(:vovo) { 100 }
hash.fetch(:gogo) { 100 }

def get_squares(array)
  max = array.last
  ans_array = []
  array.each do |cc|
    ( ans_array << cc ) if cc * cc <= max 
  end
  ans_array
end

get_squares(1..16) # => [1, 2, 3, 4]

def is_perfect_sequare(num)
  Math.sqrt(num).divmod(1)[1] == 0
end

def flatten(array)
  ans = []
  if array.kind_of?(Array)
    array.map do |aa|
      if aa.kind_of?(Array)
        aa.each { |bb| puts bb; ans << bb }
      else
        ans << aa
      end
    end
  end
  ans
end

def flattenV2(array)
  array.inject([]) { |result, elem| result + (elem.is_a?(Array) ? elem : [elem]) }
end

flatten [1,2,3] # => [1, 2, 3]


def sort_reindeer reindeer_names
  reindeer_names.sort_by{|string| string.split(" ").last}
end

sort_reindeer([ # => 
  "Dasher Tonoyan",  # => "Dasher Tonoyan"
  "Dancer Moore",  # => "Dancer Moore"
  "Prancer Chua",  # => "Prancer Chua"
  "Vixen Hall",  # => "Vixen Hall"
  "Comet Karavani",         # => "Comet Karavani"
  "Cupid Foroutan",  # => "Cupid Foroutan"
   "Donder Jonker",  # => "Donder Jonker"
   "Blitzen Claus" # => "Blitzen Claus"
]) # => ["Prancer Chua", "Blitzen Claus", "Cupid Foroutan", "Vixen Hall", "Donder Jonker", "Comet Karavani", "Dancer Moore", "Dasher Tonoyan"]

def solution(pairs)
  puts pairs
  pairs.each.map{|k,v| "#{k}: #{v}"}.join(",")
end

solution({a:2,b:2}) # => 

# ~> ArgumentError
# ~> wrong number of arguments (1 for 0)
# ~>
# ~> /var/folders/z4/d6t82x0n0k5_36t11tfgrnxh0000gn/T/seeing_is_believing_temp_dir20141210-69831-1n28y3t/program.rb:81:in `solution'
# ~> /var/folders/z4/d6t82x0n0k5_36t11tfgrnxh0000gn/T/seeing_is_believing_temp_dir20141210-69831-1n28y3t/program.rb:85:in `<main>'
