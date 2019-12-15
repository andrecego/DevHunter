# frozen_string_literal: true

class Job < ApplicationRecord
  enum position: { intern: 0, junior: 5, middle: 10, senior: 15, expert: 20,
                   manager: 25 }
end
