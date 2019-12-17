# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    full_name { 'My String' }
    social_name { 'String' }
    birthdate { 18.years.ago }
    qualifications { 'MyString' }
    description { 'MyText' }
    experience { 'MyText' }
    status { 'pending' }
    user
  end
end
