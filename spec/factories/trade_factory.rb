FactoryBot.define do
  factory :trade do

    symbol      { 'btc' }
    total_coins { 10 }
    dollars     { 100 }
    price       { 10 }

    trait :buy do
      trade_type  { 'buy' }
    end

    trait :sell do
      trade_type  { 'sell' }
    end
  end
end