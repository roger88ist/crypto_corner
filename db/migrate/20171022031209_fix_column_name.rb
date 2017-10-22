class FixColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :trades, :type, :trade_type
  end
end
