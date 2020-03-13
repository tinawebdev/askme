class Hashtag < ApplicationRecord
  REGEX = /#[[:word:]]+/

  before_save :set_slug
  
  has_many :hashtags_questions, dependent: :destroy
  has_many :questions, through: :hashtags_questions  

  scope :sorted, -> { order(:name) }

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.parameterize
  end
end