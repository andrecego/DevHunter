# frozen_string_literal: true

FactoryBot.define do
  factory :approval do
    start_date { '2019-12-25' }
    wage { 1 }
    aid { 'MyText' }
    inscription
  end
end
