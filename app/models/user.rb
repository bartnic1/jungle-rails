class User < ActiveRecord::Base
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false }
  validates :password, presence: true, length: {minimum: 1}

  has_secure_password

  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email[/\S+/, 0].downcase)
    if user
      return user.authenticate(password)
    else
      return false
    end
  end
end
