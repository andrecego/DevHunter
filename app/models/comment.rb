# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :hunter

  validates :body, presence: true
end
