class AddPublicAccToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :public_acc, :boolean, default: true
  end
end
