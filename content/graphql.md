+++
date = "2017-03-27T11:12:25+08:00"
draft = true
title = "graphql"

+++
#GraphQL::ObjectType
  - api entrypoint.
  - describe objects and values in a system.
  - argument
  ```
  MutationType = GraphQL::ObjectType.define do
    name "Mutation"
    description "Root Mutation Schema"

    field :persist_program do
      type !ProgramType // return type, can be a defaulte type type.xxx self defined class GraphQL::InputObjectType
      argument :trainee_uuid, !types.String // argument can be pass in
      argument :program, !ProgramInput // ! means this is a required argument
      resolve -> (obj, args, ctx) do // get data
        program_hash = args["program"].to_h
        program_hash["trainee_uuid"] = args["trainee_uuid"]
        ProgramResolver.persist(program_hash, args["case_id"])
      end
    end
  end
  ```
  - [defined lambda by dash rocket](http://stackoverflow.com/questions/8476627/what-do-you-call-the-operator-in-ruby)
    - ->(x) { x * 2 }
    - lambda { |x| x * 2 }
  - [instance_definable](https://github.com/rmosolgo/graphql-ruby/blob/master/lib/graphql/define/instance_definable.rb#L18)
    - provide .define for {GraphQL::BaseType}, {GraphQL::Field}
    - provide .accepts_definitions
  - Fields
    - [Fields](http://www.rubydoc.info/github/rmosolgo/graphql-ruby/GraphQL/Field)
    - [Fields](https://github.com/rmosolgo/graphql-ruby/blob/master/lib/graphql/field.rb)
    - field do ... end block is passed to GraphQL::Field’s .define method
    - Fields can take inputs; they're called (by) arguments. You can define them with the argument helper.
    - {Field}s belong to {ObjectType}s and {InterfaceType}s.
    - They're usually created with the `field` helper. If you create it by hand, make sure {#name} is a String.
    - [type def](https://github.com/rmosolgo/graphql-ruby/blob/master/lib/graphql/field.rb#L220)
      - GraphQL::BaseType
    ```
      PostType = GraphQL::ObjectType.define do
        // name, return type, description?
        field :teaser, types.String, "The teaser of the Post" do
        resolve ->(obj, args, ctx) {
          obj.body[0, 40]
        }
      end
    ``` 
    - resolve params
      - object: The underlying object for this type (above, a Post instance) # TOCHECK maybe it is by name of instance???
      - arguments: The arguments for this field (see below, a GraphQL::Query::Arguments instance)
      - context: The context for this query (see “Executing Queries”, a GraphQL::Query::Context instance)
