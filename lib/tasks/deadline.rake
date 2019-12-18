# frozen_string_literal: true

namespace :deadline do
  desc 'Change the status of a Job after the deadline is past'
  task check_end_date: :environment do
    Job.where(status: 'active').each do |x|
      x.inactive! if Date.today > x.deadline
    end
  end
end
