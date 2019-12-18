# frozen_string_literal: true

require 'rails_helper'

feature 'User with a completed profile' do
  scenario 'view path for edit his profile' do
    user = create(:user)
    create(:profile, status: 'complete', user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    within '#profile' do
      click_on 'Editar'
    end

    expect(current_path).to eq edit_profile_path(user)
  end

  scenario 'view path for edit his account' do
    user = create(:user)
    create(:profile, status: 'complete', user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Editar minha conta'

    expect(current_path).to eq edit_user_registration_path(user)
  end

  scenario 'view path for his applied jobs' do
    user = create(:user)
    create(:profile, status: 'complete', user: user)
    create(:inscription, user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Minhas vagas'

    expect(current_path).to eq inscriptions_path
  end
end
