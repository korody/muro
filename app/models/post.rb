class Post < ActiveRecord::Base
  attr_accessor :from_user

  # before_save :assign_user

  belongs_to :user

  # validates_presence_of :from_user, :title
  validates :content, presence: true, length: { minimum: 7 }, uniqueness: { case_sensitive: false }

  def assign_user
    random_person = from_user.present? ? User.where(name: from_user).first_or_create! : User.find(4)
    self.user_id = random_person.id
  end

end
