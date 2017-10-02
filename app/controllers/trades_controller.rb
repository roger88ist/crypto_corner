class TradesController < ApplicationController

	before_action :authenticate_user!

	def index
		@trades = Trade.for_trades_index(current_user)
	end

	def new
		@trade = Trade.new
	end

	def create
		TradeService.create_trade(trade_params, current_user)

		redirect_to trades_path
	end

	private

	def trade_params
		params.require(:trade).permit(:symbol, :total_coins, :dollars, :date)
	end
end
