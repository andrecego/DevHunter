# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor register new Hunter account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Registre-se'
    choose 'Headhunter'
    within '#headhunter' do
      fill_in 'E-mail', with: 'hunter@hunter.com'
      fill_in 'Senha', with: 'hunter2'
      fill_in 'Confirmação de senha', with: 'hunter2'
      click_on 'Inscreva-se'
    end

    expect(page).to have_content('Você realizou seu registro como Headhunter')
  end

  scenario 'and didnt fill in all fields' do
    visit root_path
    click_on 'Registre-se'
    choose 'Headhunter'
    within '#headhunter' do
      fill_in 'E-mail', with: ''
      click_on 'Inscreva-se'
    end
    sleep(1)
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'and password doesnt match the confirmation' do
    visit root_path
    click_on 'Registre-se'
    choose 'Headhunter'
    within '#headhunter' do
      fill_in 'E-mail', with: 'hunter@hunter.com'
      fill_in 'Senha', with: 'hunter2'
      fill_in 'Confirmação de senha', with: 'hunter1'
      click_on 'Inscreva-se'
    end

    expect(page).to have_content('Confirmação de senha não é igual a Senha')
  end

  scenario 'and email is already in use' do
    create(:hunter, email: 'hunter@hunter.com')

    visit root_path
    click_on 'Registre-se'
    choose 'Headhunter'
    within '#headhunter' do
      fill_in 'E-mail', with: 'hunter@hunter.com'
      fill_in 'Senha', with: 'hunter2'
      fill_in 'Confirmação de senha', with: 'hunter2'
      click_on 'Inscreva-se'
    end
    expect(page).to have_content('E-mail já está em uso')
  end
end
