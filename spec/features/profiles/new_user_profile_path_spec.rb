# frozen_string_literal: true

require 'rails_helper'

feature 'New user complete the profile' do
  scenario 'successfully' do
    visit root_path
    click_on 'Registre-se'
    within '#user' do
      fill_in 'E-mail', with: 'usuario@usuario.com'
      fill_in 'Senha', with: 'senha123'
      fill_in 'Confirmação de senha', with: 'senha123'
      click_on 'Inscrever-se'
    end

    fill_in 'Nome Completo', with: 'Andre Cesar Gomes'
    fill_in 'Nome Social', with: 'Andre'
    fill_in 'Data de Nascimento', with: '27/04/1992'
    fill_in 'Formação', with: 'Bacharelado em Engenharia Química'
    fill_in 'Descrição', with: 'Buscando novos conhecimentos'
    fill_in 'Experiência', with: 'Desenvolvedor Sênior na Google'
    # attach_file("Foto de Perfil", Rails.root + "spec/fixtures/user_photo.png")
    click_on 'Salvar'

    expect(page).to have_content('Perfil salvo com sucesso')
    expect(page).to have_content('Andre Cesar Gomes')
    expect(page).to have_content('Andre')
    expect(page).to have_content('27/04/1992')
    expect(page).to have_content('Bacharelado em Engenharia Química')
    expect(page).to have_content('Buscando novos conhecimentos')
    expect(page).to have_content('Desenvolvedor Sênior na Google')
    # expect(page).to have_content('user_photo.png')
  end
end
