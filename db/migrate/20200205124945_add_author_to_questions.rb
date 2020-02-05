class AddAuthorToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :author_id, :string
    add_index :questions, :author_id
  end
end
