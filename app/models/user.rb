class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token
  #attr_accessor :cur_motivation, :max_motivation
  
  enum gender: [:female, :male, :genderqueer, :nonbinary, :other, :lizard]
  has_many :newsposts
  # Save / Validation stuff
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  # Must have email and username, and they must be reasonable length. Bio not necessary. Stats automatically created.
  validates :name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
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
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # def is_admin?
  # 	self.admin
  # end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  
  # Stat and Game-mechanic related methods
  
  
	# Resets every users motivation to their max
	def reset_motivation
		self.cur_motivation = self.max_motivation
		save!
	end
  
  
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
end
