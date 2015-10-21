class User < ActiveRecord::Base
  attr_accessor :remember_token, :reset_token

  before_save { self.email = email.downcase }

  has_secure_password
  #this adds the user.authenticate method

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  # validates :phone_number, :presence => true
  validates :password_digest, :presence => true, length: { minimum: 6 }


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  # We create a token and store an encrypted version in the db
  # Then we store the user's encrypted id and unencrypted token  as a browser cookie
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token)) #this is self.remember_token
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the remember token from the cookie encrypts to match the digest.
  def authenticated?(which_token, token_from_cookie)
    digest = send("#{which_token}_digest") #this retrieves whatever digest

    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token_from_cookie)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  #
  # def password
  #   @password ||= Password.new(password_hash)
  # end
  #
  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end

end