class Admin::LogsController < ApplicationController

	before_action :check_admin

	def index
		@logs = Log.all.joins(:user).joins(:product)
	end
end
