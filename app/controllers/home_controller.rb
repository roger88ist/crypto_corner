class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
		@total_investment = Trade.total_user_investment(current_user)
	end
	
end