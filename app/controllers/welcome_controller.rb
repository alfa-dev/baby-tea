class WelcomeController < ApplicationController

	before_action :redirect_to_user_path 


	def redirect_to_user_path
		redirect_to user_path(current_user) if current_user
	end

end
