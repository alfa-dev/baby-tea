class Admin::UsersController < ApplicationController

	before_action :check_admin

	def index
		@users = User.joins(:products).group('users.id')
	end

end
