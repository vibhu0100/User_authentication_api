class AddContactToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact, :integer
  end
end
