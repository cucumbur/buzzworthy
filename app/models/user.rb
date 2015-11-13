class User < ActiveRecord::Base
    enum gender: [:female, :male, :genderqueer, :nonbinary, :other, :lizard]
    before_save { self.email = email.downcase }
    # Must have email and username, and they must be reasonable length. Bio not necessary. Stats automatically created.
    validates :name, presence: true, length: { maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
    
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    
    
end
