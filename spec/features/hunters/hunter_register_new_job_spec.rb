# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter register new job' do
  scenario 'successfully' do
    hunter = FactoryBot.create(:hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'
    click_on 'Cadastrar nova vaga'
    fill_in 'Título', with: 'Desenvolvedor Jr.'
    fill_in 'Descrição', with: 'Aplicação de testes em Ruby on Rails'
    fill_in 'Habilidades desejadas', with: 'HTML, CSS, RSpec e Capybara'
    fill_in 'Salário Mínimo', with: '2499'
    fill_in 'Salário Máximo', with: '3001'
    select 'Júnior', from: 'Nível'
    fill_in 'Data limite', with: Date.tomorrow
    fill_in 'Local', with: 'Av Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Vaga registrada com sucesso')
    expect(page).to have_content('Vaga para Desenvolvedor Jr')
    expect(page).to have_content('Aplicação de testes em Ruby on Rails')
    expect(page).to have_content('HTML, CSS, RSpec e Capybara')
    expect(page).to have_content('R$ 2.499,00 - R$ 3.001,00')
    expect(page).to have_content('Nível: Júnior')
    expect(page).to have_content('Data limite: ' \
                                 "#{Date.tomorrow.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Local: Av Paulista')
  end

  scenario 'and didnt fill in all the fields' do
    hunter = FactoryBot.create(:hunter)
    login_as(hunter, scope: :hunter)

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

  scenario 'and maximum wage > minimum wage' do
    hunter = FactoryBot.create(:hunter)
    login_as(hunter, scope: :hunter)

    visit new_job_path
    fill_in 'Título', with: 'Desenvolvedor Jr.'
    fill_in 'Descrição', with: 'Aplicação de testes em Ruby on Rails'
    fill_in 'Habilidades desejadas', with: 'HTML, CSS, RSpec e Capybara'
    fill_in 'Salário Mínimo', with: '3399'
    fill_in 'Salário Máximo', with: '2199'
    select 'Júnior', from: 'Nível'
    fill_in 'Data limite', with: 1.day.from_now
    fill_in 'Local', with: 'Av Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Algo deu errado')
    expect(page).to have_content('Salário Máximo não pode ser menor que ' \
                                 'Salário Mínimo')
  end

  scenario 'and wages are negative' do
    hunter = FactoryBot.create(:hunter)
    login_as(hunter, scope: :hunter)

    visit new_job_path
    fill_in 'Título', with: 'Desenvolvedor Jr.'
    fill_in 'Descrição', with: 'Aplicação de testes em Ruby on Rails'
    fill_in 'Habilidades desejadas', with: 'HTML, CSS, RSpec e Capybara'
    fill_in 'Salário Mínimo', with: '-10'
    fill_in 'Salário Máximo', with: '-1'
    select 'Júnior', from: 'Nível'
    fill_in 'Data limite', with: 1.day.from_now
    fill_in 'Local', with: 'Av Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Algo deu errado')
    expect(page).to have_content('Salário Mínimo deve ser maior que 0')
    expect(page).to have_content('Salário Máximo deve ser maior que 0')
  end

  scenario 'and filled in a date in the past' do
    hunter = FactoryBot.create(:hunter)
    login_as(hunter, scope: :hunter)

    visit new_job_path
    fill_in 'Título', with: 'Desenvolvedor Jr.'
    fill_in 'Descrição', with: 'Aplicação de testes em Ruby on Rails'
    fill_in 'Habilidades desejadas', with: 'HTML, CSS, RSpec e Capybara'
    fill_in 'Salário Mínimo', with: '2499'
    fill_in 'Salário Máximo', with: '3001'
    select 'Júnior', from: 'Nível'
    fill_in 'Data limite', with: 1.day.ago
    fill_in 'Local', with: 'Av Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Algo deu errado')
    expect(page).to have_content('Data limite não pode ser menor que hoje')
  end

  scenario 'headhunter is logged in' do
    hunter = FactoryBot.create(:hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Headhunter'

    expect(page).to have_content('Cadastrar nova vaga')
  end

  scenario 'user is logged in' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit new_job_path

    expect(page).to have_content('Você precisa ser um Headhunter para ver' \
                                 ' esta área')
    expect(page).to_not have_content('Cadastrar nova vaga')
  end

  scenario 'and the user can view it' do
    create(:job, title: 'Desenvolvedor Jr', description: 'Dev. em Rails')
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Desenvolvedor Jr')
    expect(page).to have_content('Dev. em Rails')
  end
end
Warden.test_reset!
