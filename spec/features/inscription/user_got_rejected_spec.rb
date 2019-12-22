require 'rails_helper'

feature 'User got rejected' do
  scenario 'successfully' do
    user = create(:user, email: 'candidate@email.com')
    create(:profile, user: user)
    hunter = create(:hunter)
    job = create(:job, hunter: hunter, title: 'Estilista')
    inscription = create(:inscription, job: job, user: user)
    create(:rejection, inscription: inscription, feedback: 'Não tem o perfil.')
    inscription.rejected!
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Minhas vagas'
    click_on 'Rejeitado'

    expect(page).to have_content('Não tem o perfil.')
  end
end