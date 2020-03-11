require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_VALIDATION = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  USER_VALIDATION = /\A[\w]+\z/
  BGCOLOR_REGEXP = /#([a-f\d]{6}|[a-f\d]{3})\z/i

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: EMAIL_VALIDATION }
  validates :username, length: { maximum: 40 }, format: { with: USER_VALIDATION }
  validates :password, presence: true, confirmation: true, on: :create
  validates :bgcolor, format: { with: BGCOLOR_REGEXP }

  before_validation :normalize_username_and_email
  before_save :encrypt_password
  before_save :set_slug

  scope :sorted, -> { order(created_at: :desc) }

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(
              password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
      )
    end
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = username.parameterize
  end

  def normalize_username_and_email
    self.username&.downcase!
    self.email&.downcase!
  end
end
