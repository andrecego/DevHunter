# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter view their own jobs' do
  scenario 'successfully' do
    hunter = create(:hunter)
    create(:job, title: 'Dev Java', hunter: hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'

    expect(page).to have_link('Dev Java')
  end
end
