class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :trades, dependent: :destroy

  serialize :coins, Hash

  def update_coins_based_on_trades

    self.coins = {}

    self.trades.each do |trade|
      ticker = trade.symbol.to_sym
      if self.coins[ticker].nil?
        self.coins[ticker] = TradeService.coin_hash
      end
      self.coins[ticker][:amount] += trade.total_coins
      self.coins[ticker][:dollars_spent] += trade.dollars
    end

    self.save
  end

end
