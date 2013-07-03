class Post < ActiveRecord::Base
  attr_accessor :from_user

  # before_save :assign_user

  belongs_to :user

  validates_presence_of :from_user, :title
  validates :content, presence: true, length: { minimum: 7 }, uniqueness: { case_sensitive: false }

  def assign_user
    random_person = User.where(name: from_user).first_or_create!
    self.user_id = random_person ? random_person.id : 0
  end

end
