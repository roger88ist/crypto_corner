class TradesController < ApplicationController

	before_action :authenticate_user!

	def index
		@user = current_user.email
		@trades = Trade.all
	end

	def new
		@trade = Trade.new
	end

	def create
		Trade.create(trade_params)

		redirect_to trades_path
	end

	private

	def trade_params
		params.require(:trade).permit(:symbol, :total_coins, :dollars)
	end
end
