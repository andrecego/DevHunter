# frozen_string_literal: true

require 'rails_helper'

feature 'Search jobs' do
  context 'as a logged in user' do
    before(:each) do
      user = create(:user)
      login_as(user, scope: :user)
    end

    scenario 'to find one' do
      create(:job, title: 'Farmaceutico')

      visit root_path
      click_on 'Vagas'
      fill_in 'Pesquisa', with: 'Farmaceutico'
      click_on 'Buscar'

      expect(page).to have_content('Busca por Farmaceutico')
      expect(page).to have_content('Vaga para Farmaceutico')
    end

    scenario 'but didnt found any' do
      create(:job, title: 'Farmaceutico')

      visit root_path
      click_on 'Vagas'
      fill_in 'Pesquisa', with: 'Marketing'
      click_on 'Buscar'

      expect(page).to have_content('Busca por Marketing')
      expect(page).to have_content('Nenhuma vaga encontrada')
    end

    scenario 'and have multiple jobs' do
      hunter = create(:hunter)
      create(:job, hunter: hunter, title: 'Analista',
                   description: 'Vaga para um analista de conteudos')
      create(:job, hunter: hunter, title: 'Marketing')
      create(:job, hunter: hunter, title: 'An. Dados',
                   description: 'Vaga para analista de dados')

      visit root_path
      click_on 'Vagas'
      fill_in 'Pesquisa', with: 'Analista'
      click_on 'Buscar'

      expect(page).to have_content('Busca por Analista')
      expect(page).to have_css('a', text: 'Vaga para Analista', count: 1)
      expect(page).to have_css('a', text: 'Vaga para An. Dados', count: 1)
      expect(page).to_not have_content('Vaga para Marketing')
    end
  end

  context 'as a logged in headhunter' do
    scenario 'and found one' do
      hunter = create(:hunter)
      login_as(hunter, scope: :hunter)
      create(:job, title: 'Operador de caixa', hunter: hunter)

      visit root_path
      click_on 'Vagas'
      fill_in 'Pesquisa', with: 'caixa'
      click_on 'Buscar'

      expect(page).to have_content('Busca por caixa')
      expect(page).to have_content('Vaga para Operador de caixa')
    end

    scenario 'and didnt find any' do
      hunter = create(:hunter)
      login_as(hunter, scope: :hunter)
      another_hunter = create(:hunter, email: 'another@email.com')
      create(:job, title: 'Operador de caixa', hunter: another_hunter)
      create(:job, title: 'Telemarketing', hunter: hunter)

      visit root_path
      click_on 'Vagas'
      fill_in 'Pesquisa', with: 'caixa'
      click_on 'Buscar'

      expect(page).to have_content('Busca por caixa')
      expect(page).to have_content('Nenhuma vaga encontrada')
      expect(page).to_not have_content('Vaga para Operador de caixa')
    end

    scenario 'and found multiple' do
      hunter = create(:hunter)
      login_as(hunter, scope: :hunter)
      another_hunter = create(:hunter, email: 'another@email.com')
      create(:job, title: 'Alfaiate', hunter: hunter,
                   description: 'Fazer redes e trançados')
      create(:job, title: 'Técnico TI', hunter: hunter,
                   description: 'Analisar sistemas e redes.')
      create(:job, title: 'Operador de caixa', hunter: another_hunter)
      create(:job, title: 'Devenvolvedor', hunter: another_hunter)

      visit root_path
      click_on 'Vagas'
      fill_in 'Pesquisa', with: 'redes'
      click_on 'Buscar'

      expect(page).to have_content('Busca por redes')
      expect(page).to_not have_content('Vaga para Operador de caixa')
    end
  end
end
