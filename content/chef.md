+++
date = "2015-12-17T10:11:08+08:00"
draft = true
title = "chef"

+++
# CHEF NOTE
## NOTE OF FOLLOWING GUIDES

```
  Learn the Chef basics
  Learn to manage a node
  Learn to manage a basic web application
  Learn to develop your infrastructure code locally
```
[Guide Link](https://learn.chef.io/tutorials/)

## Generating chef repo

  - Usually this is done by download starter kit form chef server. The setting will be included automatically.

  - `chef generate repo ~/chef-repo` A chef resource describe the state of specific file, template or package. 

## Recipe

  - A receipe is a file contains related resources, configure of web server, database server, or load balancer. 

## Run on server

  - `chef-client` fetch recipes and start running chef on server.
  - `sudo chef-client --local-mode --runlist 'recipe[learn_chef_apache2]'`
  - runlist, deciding order and which recipe need to be run.
  - debug `sudo chef-client -l debug`

## Chef server (Opscode server)

  - A chef server is a repository that save cookbooks and node informations.

## Cookbook
  - `knife cookbook upload learn_chef_apache2`
  - can download cookbooks from supermarket, a opensource cookbook community. [link](https://supermarket.chef.io/cookbooks)
  - `knife cookbook site download learn_chef_apache2`, download from supermarket
  - `chef generate cookbook cookbooks/awesome_customers` Generating cookbook.
  - `knife cookbook site show xxx | grep latest_version` Showing xxx versions in chef supermarcket
  - pining, specificying the version of cookbook in metadata.rb .
  chef will update the cookbook form chef supermarcket by the version.
    * ~> x.y.z means greate than x.y but smaller than x.y+1 . z changes means bug fixes or patches. 
  Generating recipe
  - chef generate recipe cookbooks/awesome_customers user
  - include recipe in cookbook/recipes/default.rb `include_recipe 'cookbookxxx::yyy'` means it will run that recipe when running r

### delete cookbook from Chef server
  - knife cookbook delete <cookbook-name>
  remove berkshelf cookbook locally
  - rm -r ~/.berkshelf/cookbooks
  delete repo
  - rm -r ~/chef-repo
  Delete the node from the Chef server
  - knife node delete web_app_ubuntu --yes

.erb means it can hold placeholders, filled in when recipe runs.
  https://supermarket.chef.io/cookbooks.
_
## Node
  - Node object is a object that contains its information, saved in chef server. The object will be loaded to node's memory when knife xxx. ? (link)[https://docs.chef.io/attributes.html#automatic-ohai]
  - A node is a computer, VM, container, or a phycial server managed by a chef.
  - Bootstraping the node is the process installing chef-client on a node.
  - `knife boorstrasp` is a one time process, association the node to chef server and apply cookbook.
  - `knife bootstrap` will download the chef-client to and cookbook to node and apply the cookbook.
  - set node.chef_environment by `knife bootstrap .... -E staging`

later, if just needing to apply cookbook change, use knife ssh.

## Provisioning example
  - `knife cookbook upload`
  - `knife bootstrap ADDRESS --ssh-user USER --ssh-password 'PASSWORD' --sudo --use-sudo-password --node-name node1 --run-list 'recipe[learn_chef_apache2]'`
    * --node-name is the unique identifier for chef server
    * ADDRESS needs public IP.
  - `knife node list`
  - `knife node show`
  knife ssh is for applying changed cookbook to a node after the node is bootstraped.
  - `knife ssh ADDRESS 'sudo chef-client' --manual-list --ssh-user USER --ssh-password 'PASSWORD'`
  knife with ssh key
  - `knife bootstrap ADDRESS --ssh-user USER --sudo --identity-file IDENTITY_FILE --node-name web_app_ubuntu --run-list 'recipe[awesome_customers]'`
    * IDENTITY_FILE is the ssh key location.

## Attribute

  - `chef generate attribute cookbooks/awesome_customers default` Defining customized node attributes
  - DRY the reusable content to attribute/ , use node['xxx'] to access.

## Cookbook Versioning

### Berkshelf
  - in xxx bookbook, `berks install` will fetch dependency cookbooks to local env. Saving under ./berkshelf/cookbooks/
under xxx cookbook folder. cookbook/xxx/
  - then, use `berk upload` to upload cookbooks, dependency cookbooks included, 
  - `knife cookbook list` Check is success or not 

### Chef Librian
  - `librian-chef install`

### down all data from chef server
  - `knife download /`

# Data Bag 
  - values shared among nodes.
  - can be encrypted optionally.
## encrypted
  - generate a key to encrypt databag item

  `openssl rand -base64 512 | tr -d '\r\n' > /tmp/encrypted_data_bag_secret`

  - uploading to node use scp command.

  `scp -i ~/.ssh/my.pem /tmp/encrypted_data_bag_secret ubuntu@52.10.205.36:/etc/chef`

  - creating data bag at chef server. (will do nothing at local)

  `knife data bag create passwords`

  - create local data. 
    * p.s. Not in cookbook! but in chef-repo, chef-repo/data_bags/passwords/, data bags are used by everybody cookbooks
    
    `mkdir databags/passwords`

  - create data json file in databags/passwords
  - update the password to Chef server with encryption, local file remain unencrypted
    `knife data bag from file passwords sql_server_root_password.json --secret-file /tmp/encrypted_data_bag_secret`
  verfy

  `knife data bag show passwords sql_server_root_password`

  - can verify with encrypt key file
  `knife data bag show passwords sql_server_root_password --secret-file /tmp/encrypted_data_bag_secret`
  - encrypt the json file locally
  `knife data bag from file passwords sql_server_root_password.json --secret-file /tmp/encrypted_data_bag_secret --local-mode`

## Template
  - A template is a single, general, customized recipe for specific node as recipe runs.

## knife ssh
  - `Knife ssh` will invokes the command pecified over an SSH connection on a node - here is chef-client.
  - No need to specify the run list, cookbook, because it is set up by bootstraping.
  - 'sudo chef-client' is nessary for reapply cookbook. Without that, knife ssh just update cookbook, not apply it.


# Test it locally
## Test Kitchen
  - Test Kitchen enables you to test cookboos in a temporary environment.
  - install vagrant and virtual-box (http://sourabhbajaj.com/mac-setup/Vagrant/README.html)
  - `.kitchen.ymla will be created automacally when creating cookbook using `chef generate cookbook motd`
  - modify .kitchen.yml in cookbook.
    * driver specifies the software that manages the machine. We're using Vagrant.
    * provisioner specifies how to run Chef.
    * platforms specifies the target operating systems. 
    * suites specifies what - e.g. cookbook - we want to apply to the virtual environment. 


- `kitchen list` list virtual environments create virtual enviroments
- `kitchen create` apply cookbook
- `kitchen converge, slower at first time because it need to install chef-client, will create instance if not created yet`
login to instance
- `kitchen login` logout in instance after login
- `logout` delete instance
- `kitchen destroy`

# assign ip, cookbook and data bag in .kitchen.yml
```yml
driver:
  network:
  - ["private_network", {ip: "x.x.x.x"}]
suits:
  - name: default
    data_bags_path: "../../data_bags"
    run_list:
      - recipe[awesome_customers::default]
    attributes:
      awesome_customers:
        passwords:
          secret_path: 'tmp/kitchen/encrypted_data_bag_secret'
```

## chef-client dry run (why-run)

chef-client --why-run
chef-client -W

## chef_environment
  - set
    - set in recipe
    - set when bootstraping
    - (https://docs.chef.io/environments.html)
  - use
    - node.chef_environment
    - Specifically, chef_environment is a method on the Chef::Node object that returns the value of the node's environment. It is not a node attribute and should not be confused as such.
    - (http://serverfault.com/questions/417696/how-to-find-the-chef-environment-in-a-recipe)


# after upgrade passenger and ruby

- sudo chef-client

see Apache2 be starting or not
- service --status-all

see Apache or Passenger is the new one or not
- ps aux

restart Apache2
- sudo service apache2 restart

tell passenger to restart
- touch tmp/restart.txt

apache folder
/etc/apache2/
/etc/apache2/mods-available
/etc/apache2/mods-enables

update .ruby-version



##Debug log
rails_proj/log/
/var/apache2/log/...
