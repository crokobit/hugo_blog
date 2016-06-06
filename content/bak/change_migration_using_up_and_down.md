in Rails 3.x, we have up and down for rake db:migrate and rake db:rollback separately;
in Rails 4.x, it offer a more convenient way change for both db migrate and rollback, that is, rake db:migrate and rake db:rollback all look up change.
however, I would suggest using up and down in this case to record our previous column type, so that if we use rake db:rollback, it'll know what previous type is.
# Rails 4.x
class ChangeAmountToInteger < ActiveRecord::Migration
  def change
    change_column :policytype_excess, :amount, :integer
  end
end

# Rails 3.x
class ChangeAmountToInteger < ActiveRecord::Migration
  def up
    change_column :policytype_excess, :amount, :integer
  end

  def down
    change_column :policytype_excess, :amount, :decimal, precision: 10, scale: 2
  end
end
