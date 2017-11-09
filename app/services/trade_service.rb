class TradeService

  def self.create_buy_trade(attributes, current_user)
    attributes[:price] = attributes[:dollars].to_f / attributes[:total_coins].to_f
    attributes[:user_id] = current_user.id
    attributes[:trade_type] = 'buy'
    if Trade.create(attributes)
      update_user_coins(attributes, current_user)
    end
  end

  def self.total_user_investment(user)
    Trade.by_user(user).pluck(:dollars).inject(&:+)
  end

  def self.refresh_all_users_coins
    User.all.each do |user|
      user.update_coins_based_on_trades
    end
  end

  private

  def self.update_user_coins(attributes, user)
    symbol = attributes[:symbol].to_sym
    dollars = attributes[:dollars].to_f
    total_coins = attributes[:total_coins].to_f
    if user.coins[symbol].nil?
      user.coins[symbol] = coin_hash
    end
    user.coins[symbol][:amount] += total_coins
    user.coins[symbol][:dollars_spent] += dollars
    user.save
  end

  def self.coin_hash
    { amount: 0, dollars_spent: 0 }
  end

end