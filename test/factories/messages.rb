FactoryGirl.define do
  factory :message do
    body "MyText"
    sender_id 1
    receiver_id 1
    conversation_id 1
  end
end
