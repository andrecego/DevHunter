# frozen_string_literal: true

class Inscription < ApplicationRecord
  belongs_to :user
  belongs_to :job
  validate :user_has_a_profile

  def user_has_a_profile
    return if user.profile.present? && !user.profile.pending?

    errors.add(:user, 'precisa preencher o perfil para poder se candidatar')
  end
end
