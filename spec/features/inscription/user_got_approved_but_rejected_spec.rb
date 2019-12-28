# frozen_string_literal: true

require 'rails_helper'

feature 'User got approved' do
  context 'but declined the offer' do
    before(:each) do
      user = create(:user, email: 'candidate@email.com')
      create(:profile, user: user)
      hunter = create(:hunter)
      job = create(:job, hunter: hunter, title: 'Alfaiate')
      @inscription = create(:inscription, job: job, user: user)
      @approval = create(:approval, inscription: @inscription, aid: 'VR e TR',
                                    start_date: 7.days.from_now, wage: 2020)
      @inscription.approved!
      login_as(user, scope: :user)
    end

    scenario 'successfully' do
      visit root_path
      click_on 'Minha conta'
      click_on 'Minhas propostas'
      click_on 'Aprovado'
      click_on 'Analisar'
      fill_in 'Comentário', with: 'Não tem como pra mim sem auxílio moradia'
      click_on 'Recusar'

      expect(page).to have_content('Proposta recusada')
      expect(page).to have_content('Recusado')
    end

    scenario 'multiple times' do
      visit root_path
      click_on 'Minha conta'
      click_on 'Minhas propostas'
      click_on 'Aprovado'
      click_on 'Analisar'
      fill_in 'Comentário', with: 'Não tem como pra mim sem auxílio moradia'
      click_on 'Recusar'

      visit new_inscription_approval_response_path(@inscription, @approval)
      fill_in 'Comentário', with: 'Quero recusar de novo'
      click_on 'Recusar'

      expect(page).to have_content('Apenas uma resposta por proposta')
    end

    scenario 'and changed his mind' do
      visit root_path
      click_on 'Minha conta'
      click_on 'Minhas propostas'
      click_on 'Aprovado'
      click_on 'Analisar'
      fill_in 'Comentário', with: 'Não tem como pra mim sem auxílio moradia'
      click_on 'Recusar'

      visit new_inscription_approval_response_path(@inscription, @approval)
      fill_in 'Comentário', with: 'Mudei de ideia tarde demais'
      click_on 'Aceitar'

      expect(page).to have_content('Apenas uma resposta por proposta')
    end
  end
end
