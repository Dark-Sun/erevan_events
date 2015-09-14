class User < ActiveRecord::Base

  attr_accessor :password

  validates :email, presence: true, 
            # format: /\A\S+@.+\.\S+\z/,
            uniqueness: { case_sensitive: false }

  validates :name,     presence: true
  validates :password, presence: true


  def password=(password)
    self.salt               = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end

  def self.authenticate(email: email, password: password)
    p "authenticate"
    user = User.find_by_email(email)
    return false unless user
    p "email ok"
    (user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)) ? user : false
  end

end