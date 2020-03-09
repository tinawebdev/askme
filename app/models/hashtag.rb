class Hashtag < ApplicationRecord
  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions

  REGEX = /#[[:word:]]+/
end