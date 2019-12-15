# frozen_string_literal: true

class Job < ApplicationRecord
  enum position: { intern: 0, junior: 5, middle: 10, senior: 15, expert: 20,
                   manager: 25 }
  validates :title, :description, :min_wage, :max_wage, :deadline,
            presence: true
  validates :min_wage, :max_wage, numericality: { greater_than: 0 }
  validate :max_wage_cannot_be_less_than_min_wage

  def max_wage_cannot_be_less_than_min_wage
    return if max_wage.blank? || min_wage.blank?
    return unless min_wage > max_wage

    errors.add(:max_wage, 'não pode ser menor que Salário Mínimo')
  end
end
