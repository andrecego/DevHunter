# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :approval
  validate :only_one_record
  enum status: { pending: 0, rejected: 5, accepted: 10 }

  def only_one_record
    response = Approval.find(approval_id).response
    return if response.nil? || response.pending?

    errors.add(:base, 'Apenas uma resposta por inscrição')
  end
end
