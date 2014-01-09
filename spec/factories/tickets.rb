FactoryGirl.define do
  factory :ticket do
    sequence(:name) { |n| "name #{n}" }
    association :sprint, factory: :sprint
    association :project, factory: :project
  end
end
