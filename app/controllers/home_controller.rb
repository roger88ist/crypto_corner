class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
		@total_investment = TradeService.total_user_investment(current_user)
	end
	
end