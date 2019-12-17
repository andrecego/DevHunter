# frozen_string_literal: true

require 'rails_helper'

feature 'User sign in' do
  context 'and is profile' do
    scenario 'is empty' do
      create(:user, email: 'user@user.com', password: '123456')

      visit root_path
      click_on 'Entrar'
      within '#user' do
        fill_in 'E-mail', with: 'user@user.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
      end

      expect(current_path).to eq(new_profile_path)
      expect(page).to have_content('Preencha seu perfil para poder se ' \
                                   'candidatar')
    end

    scenario 'is 100% completed' do
      user = create(:user, email: 'user@user.com', password: '123456')
      create(:profile, user: user, status: 'complete')

      visit root_path
      click_on 'Entrar'
      within '#user' do
        fill_in 'E-mail', with: 'user@user.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
      end

      expect(current_path).to eq(jobs_path)
      expect(page).to_not have_content('Preencha seu perfil para poder se ' \
                                       'candidatar')
      expect(page).to_not have_content('Preencha todo seu perfil para ' \
                                       'aumentar suas chances')
    end

    scenario 'is missing some fields' do
      user = create(:user, email: 'user@user.com', password: '123456')
      profile = create(:profile, user: user, social_name: '',
                                 status: 'incomplete')

      visit root_path
      click_on 'Entrar'
      within '#user' do
        fill_in 'E-mail', with: 'user@user.com'
        fill_in 'Senha', with: '123456'
        click_on 'Log in'
      end

      expect(current_path).to eq(edit_profile_path(profile))
      expect(page).to have_content('Preencha todo seu perfil para aumentar ' \
                                    'suas chances')
      expect(page).to_not have_content('Preencha seu perfil para poder se ' \
                                       'candidatar')
    end
  end
end
