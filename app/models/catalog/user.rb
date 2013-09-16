class Catalog::User < ActiveRecord::Base
	belongs_to :role

	has_secure_password

	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	before_save :set_fullname

	validates :name , presence: true, length: {maximum: 30, minimum: 4}, uniqueness: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX },
	uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: {minimum: 6, maximum: 15}
	validates :password_confirmation, presence: true

	protected

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

	def set_fullname
		self.fullname = self.name if self.fullname.blank?
	end
end
