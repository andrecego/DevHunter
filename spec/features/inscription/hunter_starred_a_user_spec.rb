# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter highlighted a user' do
  scenario 'successfully' do
    user = create(:user)
    create(:profile, :with_picture, user: user)
    hunter = create(:hunter)
    job = create(:job, hunter: hunter, title: 'Dentista')
    create(:inscription, user: user, job: job, starred: false)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Vagas'
    click_on 'Vaga para Dentista'
    click_on(class: 'fav-star')

    expect(page).to have_css('.fav-star .fa-star')
  end
end
