class TradeService

	def self.create_buy_trade(attributes, current_user)
		attributes[:price] = attributes[:dollars].to_f / attributes[:total_coins].to_f
		attributes[:user_id] = current_user.id
		attributes[:trade_type] = 'buy'
		Trade.create(attributes)
	end

	def self.total_user_investment(user)
		Trade.by_user(user).pluck(:dollars).inject(&:+)
	end
end