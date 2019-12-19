# frozen_string_literal: true

module PresenceHelper
  def user_profile_picture(user)
    user.profile.picture.blank? ? 'user_photo.png' : user.profile.picture
  end
end
