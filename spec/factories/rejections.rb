# frozen_string_literal: true

FactoryBot.define do
  factory :rejection do
    body { 'MyText' }
    inscription
  end
end
