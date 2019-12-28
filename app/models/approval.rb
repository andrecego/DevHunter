# frozen_string_literal: true

class Approval < ApplicationRecord
  belongs_to :inscription
  has_one :response
  validates :start_date, :wage, :aid, presence: true
  validate :wage_more_than_job_min_wage

  def wage_more_than_job_min_wage
    return if wage.blank?

    min_wage = inscription.job.min_wage
    return if wage >= min_wage

    errors.add(:wage, "não pode ser menor que R$: #{min_wage}")
  end
end
