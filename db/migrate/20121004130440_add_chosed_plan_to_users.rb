class AddChosedPlanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chosed_plan, :string ,:default => 'Plan1'
  end
end
