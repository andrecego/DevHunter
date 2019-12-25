# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter approved a user' do
  context 'and fill in the fields' do
    before(:each) do
      user = create(:user)
      create(:profile, user: user)
      hunter = create(:hunter)
      job = create(:job, hunter: hunter, title: 'Analista de Sistemas',
                         min_wage: 1500)
      create(:inscription, job: job, user: user)
      login_as(hunter, scope: :hunter)
    end

    scenario 'successfully' do
      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Analista de Sistemas'
      click_on 'Aceitar'
      fill_in 'Data de Início', with: 7.days.from_now
      fill_in 'Salário', with: '2000'
      fill_in 'Benefícios', with: 'VR, VT'
      click_on 'Enviar'

      expect(page).to have_content('Proposta enviada com sucesso')
      expect(page).to have_content('Aprovado')
    end

    scenario 'and didnt fill in all the fields' do
      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Analista de Sistemas'
      click_on 'Aceitar'
      fill_in 'Data de Início', with: ''
      click_on 'Enviar'

      expect(page).to have_content('Algo deu errado')
      expect(page).to have_content('Data de Início não pode ficar em branco')
      expect(page).to have_content('Salário não pode ficar em branco')
      expect(page).to have_content('Benefícios não pode ficar em branco')
    end

    scenario 'and filled the wage less than min wage of the job listing' do
      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Analista de Sistemas'
      click_on 'Aceitar'
      fill_in 'Data de Início', with: 7.days.from_now
      fill_in 'Salário', with: '1'
      fill_in 'Benefícios', with: 'VR, VT'
      click_on 'Enviar'

      expect(page).to have_content('Algo deu errado')
      expect(page).to have_content('Salário não pode ser menor que R$: 1500')
    end
  end
end

# data de inicio nao pode ser menor que amanha
