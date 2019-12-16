# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    full_name { 'MyString' }
    social_name { 'MyString' }
    birthdate { '2019-12-16' }
    qualifications { 'MyString' }
    description { 'MyText' }
    experience { 'MyText' }
    user { nil }
  end
end
