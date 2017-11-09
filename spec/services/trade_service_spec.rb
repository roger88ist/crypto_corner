require 'rails_helper'

RSpec.describe TradeService do

  describe '.create_buy_trade' do
    it 'creates a trade with type "buy"' do
      user = create(:user)
      attributes = attributes_for(:trade)

      TradeService.create_buy_trade(attributes, user)
      trade = Trade.first
      expect(trade.trade_type).to eq('buy')
    end
  end

  describe '.total_user_investment' do
    it 'returns the sum of all initial investments' do
      user = create(:user)
      2.times { create(:trade, :buy, user_id: user.id)}

      result = TradeService.total_user_investment(user)

      expect(result).to eq(200)
    end
  end

  describe '.refresh_all_users_coins' do 
    it 'updates each users #coins attribute according to their associated trades' do
      user = create(:user)
      2.times { create(:trade, user_id: user.id) }
      create(:trade, symbol: 'ltc', user_id: user.id)

      TradeService.refresh_all_users_coins

      result = {
        btc: {amount: 20, dollars_spent:200 }, 
        ltc: {amount: 10, dollars_spent:100 }, 
      }

      expect(User.first.coins).to eq(result )
    end
  end

  describe '.update_user_coins' do
    it 'updates user#coins correctly' do
      user = create(:user)
      purchase_attrs = attributes_for(:trade, :buy)
      TradeService.send(:update_user_coins, purchase_attrs, user)

      hash = {
        btc: {amount: 10, dollars_spent: 100}
      }

      expect(User.first.coins).to eq(hash)
    end
  end

end