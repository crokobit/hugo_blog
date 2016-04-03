# active_record
##lazy_load
where, find, find_by query object
will lazy load after using that
e.g.
User has_many bags, bags has attribute name
users = User.all # fire SQL query
users.first.bags # fire SQL query and lazyload bags to memory

find{}, select (Enumerable method) get item from cache if it is loaded
##eager_load
user includes

##compare

http://tomdallimore.com/blog/includes-vs-joins-in-rails-when-and-where/

# search value on relationship table
need add .references(:xxx_relationships_tables)
can not find the related api doc
http://stackoverflow.com/questions/18799934/has-many-through-how-do-you-access-join-table-attributes

## default destroy behavior differ by relationship type


##include
in or out

##joins
http://guides.rubyonrails.org/active_record_querying.html#joining-tables
to query something by join another table

User has_many bags, bags has attribute name

User.joins(:bags).where(name: 'xxx')

Payment.joins(accounts_receivable: :policy).where(policies: { no: 'N120000016' })
Agent.joins(:addresses).where(addresses: { postcode: postcode })
Object.joins(... ActiveRecord Relationship ... same level realetionship use array).where(tables: { ... })

##includes
eager loading
http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations
get item to memory for not quering db

User has_many bags, bags has attribute name

users = User.includes(:bags).all
users.each { |user| user.bags.each... }

includes(... ActiveRecord Relationship, same level relationship use array ...) # seems joins is includes


---

policy_risk_questions = @policy.policy_risk_questions.includes(:risk_question)

can use after calling a instance's relationship, if having not call that relationship yet, it will fire a SQL query, at that time, we can use includes!

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
