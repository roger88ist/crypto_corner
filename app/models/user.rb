class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :trades, dependent: :destroy

  serialize :coins, Hash

  def update_coins_based_on_trades

    trades.each do |trade|
      ticker = trade.symbol.to_sym
      if coins[ticker].nil?
        coins[ticker] = TradeService.coin_hash
      end
      coins[ticker][:amount] += trade.total_coins
      coins[ticker][:dollars_spent] += trade.dollars
    end
    
    self.save
  end

end
