# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :approval

  enum status: { pending: 0, rejected: 5, accepted: 10 }
end
