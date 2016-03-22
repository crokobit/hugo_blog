+++
date = "2016-03-21T16:21:11+08:00"
draft = true
title = "chef_node_attribute_dependency_between_cookbook"

+++

# Chef Node Attribute Dependency Between Cookbook (Derived Attribute)
  - chef have two stages when running `chef-client`
    1 Complie Time / Phase
    2 Run Time (Converage Phase)
  - (http://stackoverflow.com/questions/25980820/please-explain-compile-time-vs-run-time-in-chef-recipes)

# When using node attribute in compile time, the attribute will not be the one effected after running `chef-client`

# Solution
  - [Delayed Interpolation](https://coderanger.net/derived-attributes/)
  - (https://christinemdraper.wordpress.com/2014/10/06/avoiding-the-possible-pitfalls-of-derived-attributes/)
    - for cookbook user
      * delay assignement %{} ???
      * condition assiginement
  - [Ruby Block](http://stackoverflow.com/questions/15816208/chef-recipes-setting-node-attributes-in-ruby-block)
    * Because the value are all calculate in compile time, changing the defalut value in other cookbook will not effect the action use the default value in other cookbooks. [example](https://gist.github.com/arangamani/4659646)
    * fetch your attribute from file or data bag at run time.
  - Role attribute priority is greater than cookbook. Can set attrinutes we want in role.
  -[Lazy Evaluation](https://docs.chef.io/resource_common.html#lazy-attribute-evaluation)
    * `lazy { ruby_code }`

# Q
  - default = node ? ->YES
  - https://docs.chef.io/attributes.html
  ```ruby
    An attribute file is located in the attributes/ sub-directory for a cookbook. When a cookbook is run against a node, the attributes contained in all attribute files are evaluated in the context of the node object. Node methods (when present) are used to set attribute values on a node. For example, the apache2 cookbook contains an attribute file called default.rb, which contains the following attributes:
    default['apache']['dir']          = '/etc/apache2'
    default['apache']['listen_ports'] = [ '80','443' ]
    The use of the node object (node) is implicit in the previous example; the following example defines the node object itself as part of the attribute:
    node.default['apache']['dir']          = '/etc/apache2'
    node.default['apache']['listen_ports'] = [ '80','443' ]
  ```
