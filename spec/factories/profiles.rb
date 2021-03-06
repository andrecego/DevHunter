# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    full_name { 'My String' }
    social_name { 'String' }
    birthdate { 18.years.ago }
    qualifications { 'MyString' }
    description { 'MyText' }
    experience { 'MyText' }
    status {}
    user

    trait :with_picture do
      picture do
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets',
                                            'user_photo.png'), 'image/png')
      end
    end
  end
end
