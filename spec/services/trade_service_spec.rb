require 'rails_helper'

RSpec.describe TradeService do

  describe '.create_trade' do
    let(:user) { create(:user) }
    let(:user_with_btc) { create(:user, :with_btc)}
    let(:trade_params) { attributes_for(:trade, :buy) }

    context 'when purchasing a new coin' do
      it 'creates a trade with type "buy"' do
        TradeService.create_trade(trade_params, user)

        trade = Trade.first
        coins_hash = { btc: {amount: 10.0, dollars_spent: 100.0} }

        expect(trade.trade_type).to eq('buy')
        expect(user.coins).to eq(coins_hash)
      end
    end

    context 'when purchasing more of a previous coin' do
      it 'adds to that users coin hash' do
        TradeService.create_trade(trade_params, user_with_btc)

        trade = Trade.first
        coins_hash = { btc: {amount: 110.0, dollars_spent: 200.0} }

        expect(trade.trade_type).to eq('buy')
        expect(user_with_btc.coins).to eq(coins_hash)
      end
    end
  end

  describe '.create_buy_trade' do
    it 'creates a trade with type "buy"' do
      user = create(:user)
      attributes = attributes_for(:trade)

      TradeService.create_buy_trade(attributes, user)
      trade = Trade.first
      expect(trade.trade_type).to eq('buy')
    end
  end

  describe ".create_sell_trade" do
    let(:user) { create(:user, :with_btc) }

    context "when selling some of the coins" do
      it 'creates a trade with type "sell"' do
        attributes = attributes_for(:trade)

        TradeService.create_sell_trade(attributes, user)
        trade = Trade.first
        
        expect(trade.trade_type).to eq('sell')
        expect(User.first.coins).to eq({btc: {amount: 90.0, dollars_spent: 90.0}})
      end
    end

    context "when selling all of the coins" do
      it "removes the hash for that coin" do
        coin = 'btc'
        sell_attrs = {
          symbol: coin,
          total_coins: 100,
          dollars: 100
        }

        TradeService.create_sell_trade(sell_attrs, user)

        coins = User.first.coins.keys
        expect(coins).to_not include(coin.to_sym)
      end
    end

  end

  describe '.total_user_investment' do
    it 'returns the sum of all initial investments' do
      user = create(:user)
      2.times { create(:trade, :buy, user_id: user.id)}
      user.update_coins_based_on_trades

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
        btc: {amount: 20, dollars_spent: 200 }, 
        ltc: {amount: 10, dollars_spent: 100 }, 
      }

      expect(User.first.coins).to eq(result )
    end
  end

  describe '.update_user_coins' do
    
    context 'when buying' do
      it 'updates user#coins correctly by adding trade details' do
        user = create(:user)
        purchase_attrs = attributes_for(:trade, :buy)
        TradeService.send(:update_user_coins, purchase_attrs, user)

        hash = {
          btc: {amount: 10, dollars_spent: 100}
        }

        expect(User.first.coins).to eq(hash)
      end
    end

    context 'when selling' do
      it 'updates user#coins correctly by subtracting trade details' do
        user = create(:user, :with_btc)
        
        sell_attrs = {
          user_id: user.id,
          symbol: 'btc',
          total_coins: 50,
          dollars: 200,
          trade_type: 'sell'
        }

        TradeService.send(:update_user_coins, sell_attrs, user)

        coins_hash = {
          btc: {amount: 50.0, dollars_spent: 50.0}
        }

        expect(User.first.coins).to eq(coins_hash)
      end
    end

  end
end