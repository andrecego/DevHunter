# frozen_string_literal: true

FactoryBot.define do
  factory :hunter do
    email { "hunter#{Random.rand(1000)}@hunter.com" }
    password { 'hunter2' }
  end
end
