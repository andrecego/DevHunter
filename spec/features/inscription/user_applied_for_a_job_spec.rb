# frozen_string_literal: true

require 'rails_helper'

feature 'User applied for a job' do
  context 'as a logged in user' do
    before(:each) do
      @user = create(:user)
      login_as(@user, scope: :user)
    end

    scenario 'successfully' do
      create(:job, title: 'Marketing Digital')
      create(:profile, user: @user)

      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Marketing Digital'
      click_on 'Candidatar a vaga'

      expect(page).to have_content('Você se candidatou com sucesso')
    end

    scenario 'but doesnt have a profile' do
      create(:job, title: 'Marketing Digital')

      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Marketing Digital'
      click_on 'Candidatar a vaga'

      expect(page).to have_content('Erro ao se inscrever')
      expect(page).to have_content('Candidato precisa preencher o perfil para' \
                                   ' poder se candidatar')
    end

    scenario 'that he already was a candidate' do
      job = create(:job, title: 'Marketing Digital')
      create(:profile, user: @user)
      create(:inscription, job: job, user: @user)

      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Marketing Digital'

      expect(page).to have_content('Já inscrito')
    end
  end
end
