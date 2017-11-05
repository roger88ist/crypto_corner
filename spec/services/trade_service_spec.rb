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

end