# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor register new User account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Registre-se'
    within '#user' do
      fill_in 'E-mail', with: 'usuario@usuario.com'
      fill_in 'Senha', with: 'senha123'
      fill_in 'Confirmação de senha', with: 'senha123'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Você realizou seu registro como Candidato')
    expect(page).to have_content('Minha conta')
    expect(page).to have_content('Sair')
    expect(page).to_not have_content('Registre-se')
  end

  scenario 'and didnt fill in all fields' do
    visit signup_path
    within '#user' do
      fill_in 'E-mail', with: ''
      click_on 'Inscrever-se'
    end
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'and password doesnt match the confirmation' do
    visit signup_path
    within '#user' do
      fill_in 'E-mail', with: 'usuario@usuario.com'
      fill_in 'Senha', with: 'senha123'
      fill_in 'Confirmação de senha', with: 'senha321'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Confirmação de senha não é igual a Senha')
  end

  scenario 'and email is already in use' do
    create(:user, email: 'usuario@usuario.com')

    visit signup_path
    within '#user' do
      fill_in 'E-mail', with: 'usuario@usuario.com'
      fill_in 'Senha', with: 'senha123'
      fill_in 'Confirmação de senha', with: 'senha123'
      click_on 'Inscrever-se'
    end
    expect(page).to have_content('E-mail já está em uso')
  end
end
