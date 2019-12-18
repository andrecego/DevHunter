# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :hunter
  has_many :inscriptions
  enum position: { intern: 0, junior: 5, middle: 10, senior: 15, expert: 20,
                   manager: 25 }
  enum status: { active: 0, inactive: 5 }
  validates :title, :description, :min_wage, :max_wage, :deadline,
            presence: true
  validates :min_wage, :max_wage, numericality: { greater_than: 0 }
  validate :max_wage_cannot_be_less_than_min_wage
  validate :deadline_must_be_greater_than_today

  def max_wage_cannot_be_less_than_min_wage
    return if max_wage.blank? || min_wage.blank?
    return if min_wage <= max_wage

    errors.add(:max_wage, 'não pode ser menor que Salário Mínimo')
  end

  def deadline_must_be_greater_than_today
    return if deadline.blank?
    return if inactive?
    return if deadline > Date.today

    errors.add(:deadline, 'não pode ser menor que hoje')
  end
end
