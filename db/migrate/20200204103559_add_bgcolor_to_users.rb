class AddBgcolorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bgcolor, :string, default: '#f8f9fa'
  end
end
