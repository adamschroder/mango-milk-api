class User < ActiveRecord::Base
  require 'digest/sha1'

  attr_accessible :email, :password

  before_create { generate_token(:auth_token) }
  before_save { |user| user.email.downcase! }

  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.encrypted_password = Digest::SHA1.hexdigest(password)
    end
  end

  def clear_password
    self.password = nil
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def authenticate(email="", password="")
    user = User.find_by_email(email)

    if user && user.match_password(password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    encrypted_password == Digest::SHA1.hexdigest(password)
  end
end
