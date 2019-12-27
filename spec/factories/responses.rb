# frozen_string_literal: true

FactoryBot.define do
  factory :response do
    comment { 'MyText' }
    status { 0 }
    approval
  end
end
