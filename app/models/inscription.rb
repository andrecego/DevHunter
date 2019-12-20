# frozen_string_literal: true

class Inscription < ApplicationRecord
  belongs_to :user
  belongs_to :job
  validate :job_has_uniq_users, on: :create
  validate :user_has_a_profile

  def user_has_a_profile
    return if user.profile.present? && !user.profile.pending?

    errors.add(:user, 'precisa preencher o perfil para poder se candidatar')
  end

  def job_has_uniq_users
    return if job.users.blank? || !job.users.include?(user)

    errors.add(:user, 'já inscrito')
  end
end
