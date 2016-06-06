# active_record
##lazy_load
where, find, find_by query object
find{}, select (Enumerable method) get item from cache is it is loaded
##eager_load

##load type is relationship dependent

##include
in or out

##join
to query something by join another table

users(table) has many bags(table) has many content(attribute)

User.join(:bags).where(content: 'xxx')
##includes
Eager loading

get item to memory for not quering db

users(table) has many bags(table) has many content(attribute)

User.include(bags: :content).where()


##nested where
Object.where(tables: { another_tables: { attribute: value} })

# OOP concept

#review
##routes
##relationship

# how to design calculator
##stale object problem
##when to query db?

##module class or instance method? syntax !!
