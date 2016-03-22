+++
date = "2016-03-21T16:21:11+08:00"
draft = true
title = "chef_node_attribute_dependency_between_cookbook"

+++

# Chef Node Attribute Dependency Between Cookbook (Derived Attribute)
  - chef have two stages when running `chef-client`
    1 Complie Time
    2 Run Time
  - (http://stackoverflow.com/questions/25980820/please-explain-compile-time-vs-run-time-in-chef-recipes)

# When using node attribute in compile time, the attribute will not be the one effected after running `chef-client`

# Solution
  - [Delayed Interpolation](https://coderanger.net/derived-attributes/)
  - (https://christinemdraper.wordpress.com/2014/10/06/avoiding-the-possible-pitfalls-of-derived-attributes/)
  - [Ruby Block](http://stackoverflow.com/questions/15816208/chef-recipes-setting-node-attributes-in-ruby-block)
