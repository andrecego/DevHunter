# frozen_string_literal: true

require 'rails_helper'

describe PresenceHelper do
  describe '#user_profile_picture' do
    it 'returns default picture if user doesnt have any' do
      user = create(:user)
      create(:profile, user: user)

      expect(user_profile_picture(user)).to eq('user_photo.png')
    end

    it 'returns user picture if he already have one' do
      user = create(:user)
      create(:profile, :with_picture, user: user)

      profile_picture = user_profile_picture(user)

      expect(profile_picture.class).to eq(ActiveStorage::Attached::One)
    end
  end
end
