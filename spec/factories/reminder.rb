FactoryGirl.define do
  factory :reminder do
    message     { Forgery(:lorem_ipsum).words(7) }
    status      'A'
  end
end
