class CreateTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :trades do |t|
      t.references :user, foreign_key: true
      t.string :symbol
      t.float :total_coins
      t.float :dollars
      t.float :price
      t.string :type

      t.timestamps
    end
  end
end
