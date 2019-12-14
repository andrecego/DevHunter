# frozen_string_literal: true

FactoryBot.define do
  factory :hunter do
    email { 'hunter@hunter.com' }
    password { 'hunter2' }
  end
end
