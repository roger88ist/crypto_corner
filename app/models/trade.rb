class Trade < ApplicationRecord
  belongs_to :user

  scope :by_user, -> (user) { where(user_id: user.id) }
  scope :order_by_date, -> { order(:date) }

  def self.for_trades_index(current_user)
  	by_user(current_user).order_by_date
  end

  def self.total_user_investment(current_user)
  	by_user(current_user).pluck(:dollars).inject(&:+)
  end

end
