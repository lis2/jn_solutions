FactoryGirl.define do
  factory :commit do
    sequence(:sha) { |n| n }
    author "lis2"
    message "sample message"
    sequence(:commit_created_at) { |n| Time.now + n.minutes }
  end

  factory :release do
    association :commit
  end
end


