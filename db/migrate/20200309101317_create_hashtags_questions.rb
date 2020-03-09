class CreateHashtagsQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtags_questions do |t|
      t.references :hashtag, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
