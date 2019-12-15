# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { 'MyString' }
    description { 'MyText' }
    skills { 'MyText' }
    position { 0 }
    min_wage { 1 }
    max_wage { 1 }
    deadline { 7.days.from_now }
    location { 'MyString' }
  end
end
