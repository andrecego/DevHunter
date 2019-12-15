# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter register new job' do
  scenario 'successfully' do
    visit root_path
    click_on 'Headhunter'
    click_on 'Cadastrar nova vaga'
    fill_in 'Título', with: 'Desenvolvedor Jr.'
    fill_in 'Descrição', with: 'Aplicação de testes em Ruby on Rails'
    fill_in 'Habilidades desejadas', with: 'HTML, CSS, RSpec e Capybara'
    fill_in 'Salário Mínimo', with: '2499'
    fill_in 'Salário Máximo', with: '3001'
    select 'Júnior', from: 'Nível'
    fill_in 'Data limite', with: '30/12/2019'
    fill_in 'Local', with: 'Av Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Vaga registrada com sucesso')
    expect(page).to have_content('Vaga para Desenvolvedor Jr')
    expect(page).to have_content('Aplicação de testes em Ruby on Rails')
    expect(page).to have_content('HTML, CSS, RSpec e Capybara')
    expect(page).to have_content('R$ 2.499,00 - R$ 3.001,00')
    expect(page).to have_content('Nível: Júnior')
    expect(page).to have_content('Data limite: 30/12/2019')
    expect(page).to have_content('Local: Av Paulista')
  end

  scenario 'and didnt fill in all the fields' do
    visit new_job_path
    fill_in 'Título', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Algo deu errado')
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Salário Mínimo não pode ficar em branco')
    expect(page).to have_content('Salário Máximo não pode ficar em branco')
    expect(page).to have_content('Data limite não pode ficar em branco')
  end
end
