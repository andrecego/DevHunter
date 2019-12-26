# frozen_string_literal: true

require 'rails_helper'

feature 'User got rejected' do
  before(:each) do
    @user = create(:user, email: 'candidate@email.com')
    create(:profile, user: @user)
    @hunter = create(:hunter)
    job = create(:job, hunter: @hunter, title: 'Estilista')
    @inscription = create(:inscription, job: job, user: @user)
    @rejection = create(:rejection, inscription: @inscription,
                                    feedback: 'Não tem o perfil.')
    @inscription.rejected!
  end

  scenario 'successfully' do
    login_as(@user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Minhas vagas'
    click_on 'Rejeitado'

    expect(page).to have_content('Não tem o perfil.')
  end

  scenario 'and other user tried to view it' do
    another_user = create(:user, email: 'another@user.com')
    login_as(another_user, scope: :user)

    visit inscription_rejection_path(@inscription, @rejection)

    expect(page).to have_content('Você não tem essa permissão')
    expect(current_path).to eq(root_path)
  end

  scenario 'and other hunter tried to view it' do
    another_hunter = create(:hunter, email: 'another@hunter.com')
    login_as(another_hunter, scope: :hunter)

    visit inscription_rejection_path(@inscription, @rejection)

    expect(page).to have_content('Você não tem essa permissão')
    expect(current_path).to eq(root_path)
  end
end
