# frozen_string_literal: true

require 'rails_helper'

feature 'View jobs' do
  context 'as a logged in user' do
    before(:each) do
      user = create(:user)
      login_as(user, scope: :user)
    end

    scenario 'and has one job' do
      create(:job, title: 'Consultor SAP')

      visit root_path
      click_on 'Vagas'
      expect(page).to have_content('Vaga para Consultor SAP')
    end

    scenario 'and has more than one job' do
      hunter = create(:hunter, email: 'hunter@email.com')
      another_hunter = create(:hunter, email: 'another_hunter@email.com')
      create(:job, title: 'Consultor SAP', hunter: hunter)
      create(:job, title: 'Consultor ZAP', hunter: another_hunter)

      visit root_path
      click_on 'Vagas'
      expect(page).to have_content('Vaga para Consultor SAP')
      expect(page).to have_content('Vaga para Consultor ZAP')
    end

    scenario 'and has no job' do
      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Nenhuma vaga disponível')
    end
  end

  context 'as a logged in hunter' do
    scenario 'and he has one job' do
      hunter = create(:hunter)
      login_as(hunter, scope: :hunter)
      create(:job, title: 'Telemarketing', hunter: hunter)

      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Telemarketing')
    end

    scenario 'and he has no job' do
      hunter = create(:hunter)
      another_hunter = create(:hunter, email: 'other@hunter.com')
      login_as(hunter, scope: :hunter)
      create(:job, title: 'Telemarketing', hunter: another_hunter)

      visit root_path
      click_on 'Vagas'

      expect(page).to_not have_content('Telemarketing')
    end

    scenario 'and has many jobs' do
      hunter = create(:hunter)
      another_hunter = create(:hunter, email: 'other@hunter.com')
      login_as(hunter, scope: :hunter)
      create(:job, title: 'Gerente Auxiliar', hunter: hunter)
      create(:job, title: 'Operador de caixa', hunter: hunter)
      create(:job, title: 'Telemarketing', hunter: another_hunter)

      visit root_path
      click_on 'Vagas'

      expect(page).to have_content('Gerente Auxiliar')
      expect(page).to have_content('Operador de caixa')
      expect(page).to_not have_content('Telemarketing')
    end
  end

  scenario 'as a unathenticated guest' do
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Você precisa estar logado para ver esta área')
    expect(current_path).to eq(new_user_registration_path)
  end
end
