# [Making sense of ActiveRecord joins, includes, preload, and eager_load](http://blog.scoutapp.com/articles/2017/01/24/activerecord-includes-vs-joins-vs-preload-vs-eager_load-when-and-where)
# [preload, eager_load, includes, references, and joins in Rails](http://blog.ifyouseewendy.com/blog/2015/11/11/preload-eager_load-includes-references-joins/)
# [](http://blog.arkency.com/2013/12/rails4-preloading/)
# joins, includes, preload, and eager_load
## joins
  * use `INNER JOIN` in SQL
  * will still have N+1 query because ActiveRecord select `table.*`. Will have no join table information in that object.
  * overwride the join of includes or eager_load
# includes
  * solved N+1 Query by specifying nested relationship.
  * use 'LEFT OUTTER JOIN' when have `where` or `order`. use seperate otherwise.
    * Is a single query or two queries faster? -> Use tool to check. AR may not decided this by performance.
    * > you can experiment with a single LEFT OUTER JOIN query by adding references to the ActiveRecord relation
    * Ref 2 > includes delegates to eager_load when a where or order clause references a relationship.
# references
  * This method only works in conjunction with includes.
  * api > If you want to add conditions to your included models you’ll have to explicitly reference them.
  * api > Use to indicate that the given table_names are referenced by an SQL string, and should therefore be JOINed in any query rather than loaded separately. 
  * > It's very easy to end up initializing a significant number of records.
  * api > includes works with association names while references needs the actual table name.
  *  unsure, may no need. includes will intelligently do this?
  * Ref2 > Works only with includes, makes includes behaves like eager_load
  ``` Ref 2
Blog.includes(:posts).where(name: 'Blog 1').where(posts: {title: 'Post 1-1'})
  SQL (0.2ms)  SELECT "blogs"."id" AS t0_r0, "blogs"."name" AS t0_r1, "blogs"."author" AS t0_r2, "blogs"."created_at" AS t0_r3, "blogs"."updated_at" AS t0_r4, "posts"."id" AS t1_r0, "posts"."title" AS t1_r1, "posts"."created_at" AS t1_r2, "posts"."updated_at" AS t1_r3, "posts"."blog_id" AS t1_r4 FROM "blogs" LEFT OUTER JOIN "posts" ON "posts"."blog_id" = "blogs"."id" WHERE "blogs"."name" = ? AND "posts"."title" = ?  [["name", "Blog 1"], ["title", "Post 1-1"]]
  ```

```
#DEPRECATION WARNING: It looks like you are eager loading table(s)
# (one of: users, addresses) that are referenced in a string SQL
# snippet. For example:
#
#    Post.includes(:comments).where("comments.title = 'foo'")
#
# Currently, Active Record recognizes the table in the string, and knows
# to JOIN the comments table to the query, rather than loading comments
# in a separate query. However, doing this without writing a full-blown
# SQL parser is inherently flawed. Since we don't want to write an SQL
# parser, we are removing this functionality. From now on, you must explicitly
# tell Active Record when you are referencing a table from a string:
#
#   Post.includes(:comments).where("comments.title = 'foo'").references(:comments)
#
# If you don't rely on implicit join references you can disable the
# feature entirely by setting `config.active_record.disable_implicit_join_references = true`. (
```
```ref 3 same below

User.includes(:addresses).where("addresses.country = ?", "Poland").references(:addresses)
User.eager_load(:addresses).where("addresses.country = ?", "Poland")
```
# preload
  * same as includes
  * > Always firing two separate queries.

# eager_load
  * one query and select eager_loaded table
  * > same as includes + references* > same as includes + references* > same as includes + references* > same as includes + references* > same as includes + references* > same as includes + references* > same as includes + references* > same as includes + references


# includes without where v.s.includes with where v.s. includes + references v.s. eager_load
  * using includes without where will use two query. same as preload. firing two sql.
  * using includes with nested query string would be same as using eager_load. Firing one query sql.
  * using includes with string quering another table would have error. Need to add references. Than would be same as above

```
ProgramExercise.includes(:exercise).where("exercises.name = ''") -> error
ProgramExercise.includes(:exercise).references(:exercises).where("exercises.name = ''") ok
ProgramExercise.eager_load(:exercise).where(exercises: {name: 'Treadmil'}) same as above
```
  * Ref2 said dealing with LEFT OUTTER JOIN TABLE to rails obj may waste time. So he prefer includes.

# Ref2> should not always get nested data. Might be bad to performance.

# Ref 2 ex. includes v.s. joins + preload
```
Find all Post records with a Comment authored by Derek
Render those Post records and the total count of comments for each post
includes will only fetch Comment records authored by Derek, not all comments associated with each post.

Post.joins("LEFT OUTER JOIN comments ON comments.post_id = posts.id").where(:comments => {author: 'Derek'}).preload(:comments).map { |post| post.comments.size }
```

# Ref 2 joins and eager_laod
```
Post.joins(:comments).eager_load(:comments).map { |post| post.comments.size }
ActiveRecord will do the following:

Return an Array of Post records with comments.
Load the comments associated with each Post.
It's includes with an INNER JOIN vs. a LEFT OUTER JOIN.
```

# LEFT OUTER JOIN v.s. INNER JOIN
  * LEFT OUTTER JOIN -> have that record if have no another table's data
  * INNER JOIN -> no record if have no another table's data

# includes v.s. preload folow by where ...
  * includes -> one query. so only 'eager_load' data filter by where...
  * preload -> two queries. preload  not filter by where.
```Ref 3
User.joins(:addresses).where("addresses.country = ?", "Poland").includes(:addresses) -> get addresses where country is Poland
User.joins(:addresses).where("addresses.country = ?", "Poland").preload(:addresses) -> get all address belongs to user

```

# summary
  * filtering -> join
  *includes without where, eager_laod -> one query
  *includes with where, preload -> two query

#[Nested includes on Active Records](https://stackoverflow.com/questions/24397640/rails-nested-includes-on-active-records)
  * `A.includes( { bees: [ { cees: [ { ees: [:jays, :exes] }, :effs] }, { dees: :wise } ] }, :zees)`