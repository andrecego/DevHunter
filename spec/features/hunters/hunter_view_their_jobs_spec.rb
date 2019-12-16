# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter view their jobs' do
  scenario 'successfully' do
    hunter = create(:hunter)
    create(:job, title: 'Dev Java', hunter: hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'

    expect(page).to have_link('Dev Java')
  end

  scenario 'and another hunter try to view it' do
    hunter = create(:hunter)
    another_hunter = create(:hunter, email: 'another@hunter.com')
    create(:job, title: 'Dev Java', hunter: hunter)
    create(:job, title: 'Dev Rails', hunter: another_hunter)
    login_as(another_hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'

    expect(page).to_not have_link('Dev Java')
    expect(page).to have_link('Dev Rails')
  end

  scenario 'and is logged out' do
    hunter = create(:hunter)
    job = create(:job, title: 'Dev Java', hunter: hunter)

    visit headhunter_path(job)

    expect(page).to have_content('Você precisa ser um Headhunter para ver ' \
                                 'esta área')
  end

  scenario 'and is a user' do
    hunter = create(:hunter)
    job = create(:job, title: 'Dev Java', hunter: hunter)
    user = create(:user, email: 'user@email.com')
    login_as(user, scope: :user)

    visit headhunter_path(job)

    expect(page).to have_content('Você precisa ser um Headhunter para ver ' \
                                 'esta área')
  end
end
Warden.test_reset!
