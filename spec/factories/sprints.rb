FactoryGirl.define do
  factory :sprint do
    start { Time.now }
    after :build do |s|
      s.end = s.start + 2.week
    end
  end
end
