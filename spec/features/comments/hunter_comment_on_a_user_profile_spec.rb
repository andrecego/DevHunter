# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter comment' do
  context 'on a user profile' do
    before(:each) do
      @user = create(:user, email: 'user@email.com')
      create(:profile, user: @user, full_name: 'Andre Gomes')
      @hunter = create(:hunter, email: 'hunter@email.com')
      login_as(@hunter, scope: :hunter)
    end

    scenario 'successfully' do
      job = create(:job, title: 'Vaga para Dev', hunter: @hunter)
      create(:inscription, job: job, user: @user)

      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Dev'
      click_on 'Andre Gomes'
      fill_in 'Comentário', with: 'Gostei muito do seu perfil'
      click_on 'Enviar'

      expect(page).to have_content('Comentário postado com sucesso')
      expect(page).to have_content('Gostei muito do seu perfil')
      expect(page).to have_content(l(DateTime.now, format: :short))
    end

    scenario 'but didnt wrote anything' do
      job = create(:job, title: 'Vaga para Dev', hunter: @hunter)
      create(:inscription, job: job, user: @user)

      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Dev'
      click_on 'Andre Gomes'
      fill_in 'Comentário', with: ''
      click_on 'Enviar'

      expect(page).to have_content('Algo deu errado')
      expect(page).to have_content('Comentário não pode ficar em branco')
    end
  end
end
