# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter view their jobs' do
  scenario 'by hunters area' do
    hunter = create(:hunter)
    create(:job, title: 'Dev Java', hunter: hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'

    expect(page).to have_link('Dev Java')
  end

  scenario 'and another hunter try to view it' do
    hunter = create(:hunter)
    another_hunter = create(:hunter, email: 'another@hunter.com')
    create(:job, title: 'Dev Java', hunter: hunter)
    create(:job, title: 'Dev Rails', hunter: another_hunter)
    login_as(another_hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'

    expect(page).to_not have_link('Dev Java')
    expect(page).to have_link('Dev Rails')
  end

  scenario 'and another hunter try to view it by url' do
    hunter = create(:hunter)
    another_hunter = create(:hunter, email: 'another@hunter.com')
    job = create(:job, title: 'Dev Java', hunter: hunter)
    login_as(another_hunter, scope: :hunter)

    visit job_path(job)

    expect(page).to have_content('Essa não é uma vaga sua')
  end

  scenario 'and is logged out' do
    hunter = create(:hunter)
    job = create(:job, title: 'Dev Java', hunter: hunter)

    visit headhunter_path(job)

    expect(page).to have_content('Você precisa ser um Headhunter para ver ' \
                                 'esta área')
  end

  scenario 'and is a user' do
    hunter = create(:hunter)
    job = create(:job, title: 'Dev Java', hunter: hunter)
    user = create(:user, email: 'user@email.com')
    login_as(user, scope: :user)

    visit headhunter_path(job)

    expect(page).to have_content('Você precisa ser um Headhunter para ver ' \
                                 'esta área')
  end
end

feature 'View candidates of a job' do
  context 'as a registered hunter' do
    before(:each) do
      hunter = create(:hunter)
      @job = create(:job, title: 'Técnico de Informática', hunter: hunter)
      login_as(hunter, scope: :hunter)
    end

    scenario 'and dont have any candidate' do
      visit root_path
      click_on 'Vagas'
      click_on 'Vaga para Técnico de Informática'

      expect(page).to have_content('Nenhum candidato até o momento')
    end

    scenario 'and has one candidate' do
      user = create(:user, email: 'user@email.com')
      create(:profile, user: user, full_name: 'João Gilberto')
      create(:inscription, job: @job, user: user)

      visit job_path(@job)

      expect(page).to have_content('user@email.com')
      expect(page).to have_content('João Gilberto')
      expect(page).to_not have_content('Nenhum candidato até o momento')
    end

    scenario 'and has one candidate' do
      user = create(:user, email: 'user@email.com')
      another_user = create(:user, email: 'another_user@email.com')
      create(:profile, user: user, full_name: 'João Gilberto')
      create(:profile, user: another_user, full_name: 'Jô Soares')
      create(:inscription, job: @job, user: user)
      create(:inscription, job: @job, user: another_user)

      visit job_path(@job)

      expect(page).to have_content('user@email.com')
      expect(page).to have_content('João Gilberto')
      expect(page).to have_content('another_user@email.com')
      expect(page).to have_content('Jô Soares')
      expect(page).to_not have_content('Nenhum candidato até o momento')
    end
  end

  scenario 'as a logged in user' do
    user = create(:user, email: 'some_user@email.com')
    create(:profile, user: user, full_name: 'Roberto Carlos')
    job = create(:job, title: 'Cantor')
    create(:inscription, job: job, user: user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Vagas'
    click_on 'Vaga para Cantor'

    expect(page).to_not have_content('Roberto Carlos')
    expect(page).to_not have_content('some_user@email.com')
  end
end
