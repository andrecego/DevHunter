# frozen_string_literal: true

FactoryBot.define do
  factory :rejection do
    feedback { 'MyText' }
    inscription
  end
end
