# frozen_string_literal: true

require 'rails_helper'
require 'rake'
load './lib/tasks/deadline.rake'

describe 'deadline:check_end_date', type: :task do
  it 'should be inactive after the deadline' do
    job = create(:job, deadline: Date.tomorrow, status: 'active')

    travel_to(2.days.from_now) do
      Rake::Task['deadline:check_end_date'].execute
    end
    job.reload

    expect(job.inactive?).to eq true
  end

  it 'should be active exactly in the deadline' do
    job = create(:job, deadline: Date.tomorrow, status: 'active')

    travel_to(1.day.from_now) do
      Rake::Task['deadline:check_end_date'].execute
    end
    job.reload

    expect(job.active?).to eq true
  end

  it 'should be active before the deadline' do
    job = create(:job, deadline: Date.tomorrow, status: 'active')

    travel_to(Date.today) do
      Rake::Task['deadline:check_end_date'].execute
    end
    job.reload

    expect(job.active?).to eq true
  end
end
