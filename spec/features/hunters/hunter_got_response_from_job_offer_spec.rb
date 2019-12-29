# frozen_string_literal: true

require 'rails_helper'

feature 'Headhunter received response from job offer' do
  context 'and it was positive' do
    before(:each) do
      user = create(:user, email: 'candidate@email.com')
      create(:profile, user: user)
      hunter = create(:hunter)
      job = create(:job, hunter: hunter, title: 'Estilista')
      inscription = create(:inscription, job: job, user: user)
      approval = create(:approval, inscription: inscription,  aid: 'VR e TR',
                                   wage: 2000, start_date: 7.days.from_now)
      inscription.approved!
      @response = create(:response, approval: approval)
      @response.accepted!
      inscription.hired!
      user.inscriptions.where(status: 'approved').map(&:declined!)
      user.inscriptions.where(status: 'pending').map(&:rejected!)
      login_as(hunter, scope: :hunter)
    end

    scenario 'with a comment' do
      @response.update_attribute(:comment, 'Ansioso para começar')

      visit root_path
      click_on 'Vagas'
      click_on 'Estilista'

      expect(page).to have_content('Contratado')
      expect(page).to have_content('Comentário: Ansioso para começar')
    end

    scenario 'with no comment' do
      @response.update_attribute(:comment, '')

      visit root_path
      click_on 'Vagas'
      click_on 'Estilista'

      expect(page).to have_content('Contratado')
      expect(page).to have_content('Comentário: Sem comentários do usuário')
    end
  end

  context 'and it was negative' do
    before(:each) do
      user = create(:user, email: 'candidate@email.com')
      create(:profile, user: user)
      hunter = create(:hunter)
      job = create(:job, hunter: hunter, title: 'Estilista')
      inscription = create(:inscription, job: job, user: user)
      approval = create(:approval, inscription: inscription,  aid: 'VR e TR',
                                   wage: 2000, start_date: 7.days.from_now)
      inscription.approved!
      @response = create(:response, approval: approval)
      @response.declined!
      inscription.declined!
      login_as(hunter, scope: :hunter)
    end

    scenario 'with a comment' do
      @response.update_attribute(:comment, 'Tenho outro compromisso')

      visit root_path
      click_on 'Vagas'
      click_on 'Estilista'

      expect(page).to have_content('Recusado')
      expect(page).to have_content('Comentário: Tenho outro compromisso')
    end

    scenario 'with no comment' do
      @response.update_attribute(:comment, '')

      visit root_path
      click_on 'Vagas'
      click_on 'Estilista'

      expect(page).to have_content('Recusado')
      expect(page).to have_content('Comentário: Sem comentários do usuário')
    end
  end
end
