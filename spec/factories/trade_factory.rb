FactoryBot.define do
  factory :trade do
    trait :buy do
      symbol      { 'btc' }
      total_coins { 10 }
      dollars     { 100 }
      price       { 10 }
      trade_type  { 'buy' }
    end
  end
end