require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#coins' do
  	it 'is data type Hash' do
      user = create(:user)

      expect(user.coins).to be_a Hash
    end
  end

end