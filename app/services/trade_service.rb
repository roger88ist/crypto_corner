class TradeService

  def self.create_buy_trade(attributes, current_user)
    attributes[:price] = attributes[:dollars].to_f / attributes[:total_coins].to_f
    attributes[:user_id] = current_user.id
    attributes[:trade_type] = 'buy'
    if Trade.create(attributes)
      update_user_coins(attributes, current_user)
    end
  end

  def self.create_sell_trade(attributes, current_user)
    attributes[:price] = attributes[:dollars].to_f / attributes[:total_coins].to_f
    attributes[:user_id] = current_user.id
    attributes[:trade_type] = 'sell'
    if Trade.create(attributes)
      update_user_coins(attributes, current_user)
    end
  end

  def self.total_user_investment(user)
    user.coins.values.map { |info| info[:dollars_spent] }.inject(:+)
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

    if attributes[:trade_type] == 'sell'
      price_bought = user.coins[symbol][:dollars_spent] / user.coins[symbol][:amount]
      investment_portion_sold = total_coins * price_bought
      user.coins[symbol][:amount] -= total_coins
      user.coins[symbol][:dollars_spent] -= investment_portion_sold
    elsif attributes[:trade_type] == 'buy'
      if user.coins[symbol].nil?
        user.coins[symbol] = coin_hash
      end
      user.coins[symbol][:amount] += total_coins
      user.coins[symbol][:dollars_spent] += dollars
    end 

    user.save
  end

  def self.coin_hash
    { amount: 0, dollars_spent: 0 }
  end

end