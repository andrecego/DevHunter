# frozen_string_literal: true

require 'rails_helper'

feature 'User just sign up and' do
  context 'complete the profile' do
    before(:each) do
      visit root_path
      click_on 'Registre-se'
      within '#user' do
        fill_in 'E-mail', with: 'usuario@usuario.com'
        fill_in 'Senha', with: 'senha123'
        fill_in 'Confirmação de senha', with: 'senha123'
        click_on 'Inscreva-se'
      end
    end

    scenario 'successfully' do
      fill_in 'Nome Completo', with: 'Andre Cesar Gomes'
      fill_in 'Nome Social', with: 'Andre'
      fill_in 'Data de Nascimento', with: '27/04/1992'
      fill_in 'Formação', with: 'Bacharelado em Engenharia Química'
      fill_in 'Descrição', with: 'Buscando novos conhecimentos'
      fill_in 'Experiência', with: 'Desenvolvedor Sênior na Google'
      attach_file('Foto de Perfil', Rails.root.join('spec', 'support', 'assets',
                                                    'user_photo.png'))
      click_on 'Salvar'

      expect(page).to have_content('Perfil salvo com sucesso')
      expect(page).to have_content('Andre Cesar Gomes')
      expect(page).to have_content('Andre')
      expect(page).to have_content('27/04/1992')
      expect(page).to have_content('Bacharelado em Engenharia Química')
      expect(page).to have_content('Buscando novos conhecimentos')
      expect(page).to have_content('Desenvolvedor Sênior na Google')
      expect(page).to have_css("img[src*='user_photo.png']")
    end

    scenario 'and didnt fill in required fields' do
      fill_in 'Nome Completo', with: ''
      click_on 'Salvar'

      expect(page).to have_content('Algo deu errado')
      expect(page).to have_content('Nome Completo não pode ficar em branco')
      expect(page).to have_content('Data de Nascimento não pode ficar em ' \
                                   'branco')
      expect(page).to have_content('Formação não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
    end

    scenario 'and filled in only the required fields' do
      fill_in 'Nome Completo', with: 'Andre Cesar Gomes'
      fill_in 'Data de Nascimento', with: '27/04/1992'
      fill_in 'Formação', with: 'Bacharelado em Engenharia Química'
      fill_in 'Descrição', with: 'Buscando novos conhecimentos'
      click_on 'Salvar'

      expect(page).to have_content('Perfil salvo com sucesso')
      expect(page).to have_content('Andre Cesar Gomes')
      expect(page).to_not have_content('Nome Social')
      expect(page).to have_content('27/04/1992')
      expect(page).to have_content('Bacharelado em Engenharia Química')
      expect(page).to have_content('Buscando novos conhecimentos')
      expect(page).to_not have_content('Experiência')
      expect(page).to_not have_css("img[src*='user_photo.png']")
    end

    scenario 'and is younger than 14 years old' do
      fill_in 'Nome Completo', with: 'Andre Cesar Gomes'
      fill_in 'Nome Social', with: 'Andre'
      fill_in 'Data de Nascimento', with: 13.years.ago
      fill_in 'Formação', with: 'Bacharelado em Engenharia Química'
      fill_in 'Descrição', with: 'Buscando novos conhecimentos'
      fill_in 'Experiência', with: 'Desenvolvedor Sênior na Google'
      attach_file('Foto de Perfil', Rails.root.join('spec', 'support', 'assets',
                                                    'user_photo.png'))
      click_on 'Salvar'

      expect(page).to have_content('Algo deu errado')
      expect(page).to have_content('Você precisa ter mais que 14 anos')
    end
  end

  feature 'user have a profile' do
    scenario 'and tried to create a new one' do
      user = create(:user)
      create(:profile, status: 'complete', user: user)
      login_as(user, scope: :user)

      visit new_profile_path

      expect(page).to have_content('Você já tem um perfil')
    end
  end

  feature 'user dont have a profile' do
    scenario 'and tried to view it' do
      user = create(:user)
      login_as(user, scope: :user)

      visit profiles_path

      expect(page).to have_content('Você ainda não tem um perfil')
      expect(current_path).to eq(new_profile_path)
    end
  end
end
