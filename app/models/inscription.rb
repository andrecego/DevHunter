# frozen_string_literal: true

class Inscription < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one :rejection
  has_one :approval
  has_one :response, through: :approval
  validate :job_has_uniq_users, on: :create
  validate :user_has_a_profile
  validate :deadline_not_past
  validate :job_is_active

  enum status: { pending: 0, rejected: 5, approved: 10, hired: 15,
                 declined: 20 }

  def user_has_a_profile
    return if user.profile.present? && !user.profile.pending?

    errors.add(:user, 'precisa preencher o perfil para poder se candidatar')
  end

  def job_has_uniq_users
    return if job.users.blank? || !job.users.include?(user)

    errors.add(:user, 'já inscrito')
  end

  def deadline_not_past
    return if Date.today <= job.deadline || !pending?

    errors.add(:base, 'Prazo acabou')
  end

  def job_is_active
    return unless pending?
    return if job.active?

    errors.add(:base, 'Vaga está inativa')
  end
end
