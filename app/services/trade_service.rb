class TradeService

	def self.create_trade(attributes, current_user)
		attributes[:price] = attributes[:dollars].to_f / attributes[:total_coins].to_f
		attributes[:user_id] = current_user.id
		Trade.create(attributes)
	end
end