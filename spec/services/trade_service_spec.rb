require 'rails_helper'

RSpec.describe TradeService do

  describe '.total_user_investment' do
    it 'returns the sum of all initial investments' do
      user = create(:user)
      2.times { create(:trade, :buy, user_id: user.id)}

      result = TradeService.total_user_investment(user)

      expect(result).to eq(200)
    end
  end

  describe '.update_user_coins' do
    it 'updates user#coins correctly' do
      purchase_attrs = attributes_for(:trade, :buy)
      user = create(:user)
      TradeService.send(:update_user_coins, purchase_attrs, user)

      expect(User.first.coins).to eq({btc: {amount: 10, dollars_spent: 100}})
    end
  end

end