class TradesController < ApplicationController

	before_action :authenticate_user!

	def index
		@user = current_user.email
	end

	def new
		@hello = 'whatever'
	end

end
