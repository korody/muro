class User < ActiveRecord::Base
  has_secure_password(validations: false)

  has_many :posts

  validates_presence_of :name, :password_digest, :password, unless: :guest?
  validates :email, presence: true, length: { maximum: 60 }, email_format: true, uniqueness: { case_sensitive: false }, unless: :guest?

  before_create do
    self.remember_token = SecureRandom.urlsafe_base64
    self.email.downcase! if email
    self.username = name.gsub(/\s+/, "")
  end

end
  