# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor register new Hunter account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Headhunter'
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'hunter@hunter.com'
    fill_in 'Senha', with: 'hunter2'
    fill_in 'Confirmação de senha', with: 'hunter2'
    click_on 'Inscrever-se'

    expect(page).to have_content('Você realizou seu registro com sucesso')
  end

  scenario 'and didnt fill in all fields' do
    visit new_hunter_registration_path
    fill_in 'E-mail', with: ''
    click_on 'Inscrever-se'

    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'and password doesnt match the confirmation' do
    visit new_hunter_registration_path
    fill_in 'E-mail', with: 'hunter@hunter.com'
    fill_in 'Senha', with: 'hunter2'
    fill_in 'Confirmação de senha', with: 'hunter1'
    click_on 'Inscrever-se'

    expect(page).to have_content('Confirmação de senha não é igual a Senha')
  end

  scenario 'and email is already in use' do
    create(:hunter, email: 'hunter@hunter.com')

    visit new_hunter_registration_path
    fill_in 'E-mail', with: 'hunter@hunter.com'
    fill_in 'Senha', with: 'hunter2'
    fill_in 'Confirmação de senha', with: 'hunter2'
    click_on 'Inscrever-se'

    expect(page).to have_content('E-mail já está em uso')
  end
end
