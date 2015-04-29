FactoryGirl.define do
  factory :review do
    association :reviewer, factory: :user
    association :reviewee, factory: :user
    comment { Faker::Lorem.sentences(1).first[0..100] }
  end
end
