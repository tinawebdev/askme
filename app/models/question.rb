class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags_questions
  has_many :hashtags, through: :hashtags_questions, dependent: :destroy

  validates :text, presence: true, length: { maximum: 255 }

  after_save :create_hashtags
  after_commit :destroy_unused_hashtags, on: [:update, :destroy]

  scope :sorted, -> { order(created_at: :desc) }

  private

  def create_hashtags
    self.hashtags =
      "#{text} #{answer}".downcase.scan(Hashtag::REGEX).uniq.map do |tag|
        Hashtag.find_or_create_by(name: tag)
    end
  end

  def destroy_unused_hashtags
    Hashtag.includes(:questions).where(questions: {id: nil}).destroy_all
  end
end
