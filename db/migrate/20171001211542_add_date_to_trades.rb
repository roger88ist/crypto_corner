class AddDateToTrades < ActiveRecord::Migration[5.0]
  def change
    add_column :trades, :date, :date
  end
end
