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

  private

  def self.update_user_coins(attributes, user)
    symbol = attributes[:symbol].to_sym
    dollars = attributes[:dollars].to_f
    total_coins = attributes[:total_coins].to_f
    if user.coins[symbol].nil?
      user.coins[symbol] = User::COIN_ATTRIBUTES
    end
    user.coins[symbol][:amount] += total_coins
    user.coins[symbol][:dollars_spent] += dollars
    user.save
  end

end