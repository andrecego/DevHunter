# frozen_string_literal: true

FactoryBot.define do
  factory :approval do
    start_date { 7.days.from_now }
    wage { 10_000 }
    aid { 'MyText' }
    inscription
  end
end
