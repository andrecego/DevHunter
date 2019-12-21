# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter rejected a user inscription' do
  scenario 'successfully' do
    user = create(:user, email: 'candidate@email.com')
    create(:profile, user: user)
    hunter = create(:hunter)
    job = create(:job, hunter: hunter, title: 'Estilista')
    create(:inscription, job: job, user: user)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Vagas'
    click_on 'Vaga para Estilista'
    click_on 'Rejeitar'
    fill_in 'Feedback', with: 'Não tem o perfil da empresa'
    click_on 'Rejeitar'

    expect(page).to have_content('Candidato rejeitado com sucesso')
    expect(page).to have_content('Rejeitado')
  end
end
