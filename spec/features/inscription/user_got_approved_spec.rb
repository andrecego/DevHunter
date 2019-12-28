# frozen_string_literal: true

require 'rails_helper'

feature 'User view approved status' do
  scenario 'successfully' do
    user = create(:user, email: 'candidate@email.com')
    create(:profile, user: user)
    hunter = create(:hunter)
    job = create(:job, hunter: hunter, title: 'Estilista')
    inscription = create(:inscription, job: job, user: user)
    create(:approval, inscription: inscription, start_date: 7.days.from_now,
                      wage: 2000, aid: 'VR e TR')
    inscription.approved!
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Minhas propostas'
    click_on 'Aprovado'

    expect(page).to have_content('Data de Início: ' \
                                 "#{l(7.days.from_now.to_date)}")
    expect(page).to have_content('Salário: R$ 2.000,00')
    expect(page).to have_content('Benefícios: VR e TR')
  end

  scenario 'but didnt have any' do
    user = create(:user, email: 'candidate@email.com')
    create(:profile, user: user)
    hunter = create(:hunter)
    job = create(:job, hunter: hunter, title: 'Estilista')
    inscription = create(:inscription, job: job, user: user)
    create(:approval, inscription: inscription, start_date: 7.days.from_now,
                      wage: 2000, aid: 'VR e TR')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minha conta'
    click_on 'Minhas propostas'

    expect(page).to have_content('Nenhuma proposta')
  end
end

feature 'User got approved' do
  context 'and accepted the offer' do
    before(:each) do
      user = create(:user, email: 'candidate@email.com')
      create(:profile, user: user)
      hunter = create(:hunter)
      job = create(:job, hunter: hunter, title: 'Estilista')
      @inscription = create(:inscription, job: job, user: user)
      @approval = create(:approval, inscription: @inscription, aid: 'VR e TR',
                                    wage: 2000, start_date: 7.days.from_now)
      @inscription.approved!
      login_as(user, scope: :user)
    end

    scenario 'with a comment' do
      visit root_path
      click_on 'Minha conta'
      click_on 'Minhas propostas'
      click_on 'Aprovado'
      click_on 'Analisar'
      fill_in 'Comentário', with: 'Será um prazer trabalhar com vocês'
      click_on 'Aceitar'

      expect(page).to have_content('Proposta aceita')
    end

    scenario 'with no comment' do
      visit root_path
      click_on 'Minha conta'
      click_on 'Minhas propostas'
      click_on 'Aprovado'
      click_on 'Analisar'
      fill_in 'Comentário', with: ''
      click_on 'Aceitar'

      expect(page).to have_content('Proposta aceita')
    end

    scenario 'multiple times' do
      visit root_path
      click_on 'Minha conta'
      click_on 'Minhas propostas'
      click_on 'Aprovado'
      click_on 'Analisar'
      fill_in 'Comentário', with: 'Será um prazer trabalhar com vocês'
      click_on 'Aceitar'

      visit new_inscription_approval_response_path(@inscription, @approval)
      fill_in 'Comentário', with: 'Quero aceitar a proposta de novo'
      click_on 'Aceitar'

      expect(page).to have_content('Apenas uma resposta por proposta')
    end
  end
end
