class AddSlugToHashtags < ActiveRecord::Migration[6.0]
  def change
    add_column :hashtags, :slug, :string
  end
end
