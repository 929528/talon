class User < ActiveRecord::Base
	attr_accessible :email, :name, :password, :password_confirmation

	has_secure_password

	belongs_to :role
	belongs_to :organization
	belongs_to :department

	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	validates :name , presence: true, length: {maximum: 30, minimum: 4}, uniqueness: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: {minimum: 6, maximum: 15}
	validates :password_confirmation, presence: true
	validates :organization_id, presence: true
	validates :department_id, presence: true
	validates :role_id, presence: true

	protected

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
