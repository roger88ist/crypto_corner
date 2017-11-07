class Trade < ApplicationRecord
  belongs_to :user

  scope :by_user, -> (user) { where(user_id: user.id) }
  scope :order_by_date, -> { order(:date) }
  scope :purchases, -> { where(trade_type: 'buy') }

  def self.for_trades_index(current_user)
  	by_user(current_user).order_by_date
  end

end