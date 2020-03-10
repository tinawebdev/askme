class Hashtag < ApplicationRecord
  REGEX = /#[[:word:]]+/
  
  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions  

  scope :sorted, -> { order(:name) }
end