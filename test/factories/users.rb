FactoryGirl.define do
  factory :user do
    email { SecureRandom.hex(10) + "@example.com" }
    password { SecureRandom.hex(10) }
  end
end
