# frozen_string_literal: true

require 'rails_helper'

feature 'User edit his profile' do
  before(:each) do
    user = create(:user)
    create(:profile, user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Editar'
  end

  scenario 'successfully' do
    fill_in 'Nome Completo', with: 'Daniela Carvalho Pinto'
    fill_in 'Nome Social', with: 'Dani'
    fill_in 'Data de Nascimento', with: '01/04/1969'
    fill_in 'Formação', with: 'Gastronomia'
    fill_in 'Descrição', with: 'Buscando novos conhecimentos'
    fill_in 'Experiência', with: 'MasterChef 2018'
    attach_file('Foto de Perfil', Rails.root.join('spec', 'support', 'assets',
                                                  'user_photo.png'))
    click_on 'Salvar'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Daniela Carvalho Pinto')
    expect(page).to have_content('Dani')
    expect(page).to have_content('01/04/1969')
    expect(page).to have_content('Gastronomia')
    expect(page).to have_content('Buscando novos conhecimentos')
    expect(page).to have_content('MasterChef 2018')
    expect(page).to have_css("img[src*='user_photo.png']")
  end

  scenario 'and tried to remove required fields' do
    fill_in 'Nome Completo', with: ''
    fill_in 'Data de Nascimento', with: ''
    fill_in 'Formação', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Algo deu errado')
    expect(page).to have_content('Nome Completo não pode ficar em branco')
    expect(page).to have_content('Data de Nascimento não pode ficar em ' \
                                 'branco')
    expect(page).to have_content('Formação não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
