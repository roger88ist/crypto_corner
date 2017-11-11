require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#coins' do
  	it 'is data type Hash' do
      user = create(:user)

      expect(user.coins).to be_a Hash
    end
  end

  describe '#update_coins_based_on_trades' do
    it 'updates the coins attribute correctly' do
      user = create(:user)
      2.times { create(:trade, user_id: user.id) }
      create(:trade, symbol: 'ltc', user_id: user.id)

      user.update_coins_based_on_trades

      result = {
        btc: {amount: 20, dollars_spent:200 }, 
        ltc: {amount: 10, dollars_spent:100 }, 
      }

      expect(User.first.coins).to eq(result)
    end
  end
end