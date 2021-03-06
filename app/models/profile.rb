# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  has_many :comments

  validates :full_name, :birthdate, :qualifications, :description,
            presence: true
  validate :must_be_older_than_fourteen_years_old

  enum  status: { pending: 0, incomplete: 5, complete: 10 }

  def must_be_older_than_fourteen_years_old
    return if birthdate.blank?
    return if birthdate <= 14.years.ago.to_date

    errors.add(:base, 'Você precisa ter mais que 14 anos')
  end

  def set_status
    return unless valid?

    pending!
    return complete! if attributes.values.all?(&:present?)
    return incomplete! if valid?
  end
end
