class AdminController < ApplicationController
	before_action :check_admin
	def index
		
	end

	private
	def check_admin
		redirect_to root_path, flash: {notice: "Must be admin"} unless current_user.is_admin?
	end
end
