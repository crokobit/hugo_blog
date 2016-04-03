# Use reform without ActiveRecord Model
## It need to notice:
- attribute setting
- how to create reform object
- key and persisted?

# attribute setting

```ruby
  property :xxx, empty: true # setting attribute
```

# create reform object

```ruby
  ReformObject.new(nil)
```

# key about form_for

# ActiveRecord persisted?

# Why use reform
From Alan and Gadii:
if we no need model to sync, we can write form object by ourself.
validate can done via gem virtus.
may need to implement persisted? ...
