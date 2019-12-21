# frozen_string_literal: true

class Rejection < ApplicationRecord
  belongs_to :inscription
  validates :feedback, presence: true
end
