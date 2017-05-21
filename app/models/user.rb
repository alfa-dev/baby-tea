class User < ApplicationRecord
	
	has_many :products
	has_many :logs

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
		  user.provider 		= auth.provider
		  user.uid 				= auth.uid
		  user.name 			= auth.info.name
		  user.image 			= auth.info.image
		  user.email 			= auth.info.email
		  user.oauth_token 		= auth.credentials.token
		  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		  user.save!
		end
	end

	def is_admin?
		role == "Admin"
	end

	def first_name
		name.split(' ', 2)[0] 
	end
end
