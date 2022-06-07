class ChangeCloumnsNotnullAddCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column :customers, :introduction, :text, null: false
  end
end
