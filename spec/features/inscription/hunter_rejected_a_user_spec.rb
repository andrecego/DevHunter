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

  scenario 'but didnt provide feedback' do
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
    fill_in 'Feedback', with: ''
    click_on 'Rejeitar'

    expect(page).to have_content('Algo deu errado')
    expect(page).to have_content('Feedback não pode ficar em branco')
  end

  scenario 'but he was already rejected' do
    user = create(:user, email: 'candidate@email.com')
    create(:profile, user: user)
    hunter = create(:hunter)
    job = create(:job, hunter: hunter, title: 'Estilista')
    inscription = create(:inscription, job: job, user: user)
    create(:rejection, inscription: inscription)
    inscription.rejected!
    login_as(hunter, scope: :hunter)

    visit job_path(job)

    expect(page).to have_content('Vaga para Estilista')
    expect(page).to have_css('span', text: 'Rejeitado')
    expect(page).to_not have_button('Rejeitar')
  end
end
