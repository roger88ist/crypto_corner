FactoryBot.define do
  factory :user do
  	email 		{ 'email@email.com' }
  	password	{ 'password' }

  	trait :with_btc do
  		coins { 
  			{btc: {amount: 100, dollars_spent: 100}}
  		}
  	end
  end
end