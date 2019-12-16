# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :full_name, :birthdate, :qualifications, :description,
            presence: true
  validate :must_be_older_than_fourteen_years_old

  def must_be_older_than_fourteen_years_old
    return if birthdate.blank?
    return if birthdate <= 14.years.ago

    errors.add(:base, 'Você precisa ter mais que 14 anos')
  end
end
