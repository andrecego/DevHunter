# frozen_string_literal: true

require 'rails_helper'

feature 'Hunter closed the job offer early' do
  scenario 'successfully' do
    hunter = create(:hunter)
    create(:job, title: 'Dev Java', hunter: hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'
    click_on 'Dev Java'
    click_on 'Encerrar vaga'

    expect(page).to have_content('Vaga encerrada')
  end

  scenario 'and tried to view it' do
    hunter = create(:hunter)
    create(:job, title: 'Dev Java', hunter: hunter)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'
    click_on 'Dev Java'
    click_on 'Encerrar vaga'
    click_on 'Vagas'

    expect(page).to_not have_content('Dev Java')
    expect(page).to have_content('Nenhuma vaga disponível')
  end

  scenario 'and user tried to apply' do
    job = create(:job, title: 'Dev Java', status: :inactive)
    user = create(:user)
    login_as(user, scope: :user)

    visit job_path(job)

    expect(page).to_not have_button('Candidatar a vaga')
  end

  scenario 'and had one user with each inscription status' do
    hunter = create(:hunter)
    job = create(:job, title: 'Dev Java', hunter: hunter)
    alpha = create(:profile).user
    bravo = create(:profile).user
    charlie = create(:profile).user
    delta = create(:profile).user
    echo = create(:profile).user
    create(:inscription, user: alpha, job: job, status: :pending)
    create(:inscription, user: bravo, job: job, status: :rejected)
    approved = create(:inscription, user: charlie, job: job, status: :approved)
    hired = create(:inscription, user: delta, job: job, status: :hired)
    declined = create(:inscription, user: echo, job: job, status: :declined)
    neutral = create(:approval, inscription: approved)
    positive = create(:approval, inscription: hired)
    negative = create(:approval, inscription: declined)
    create(:response, approval: neutral, status: :pending)
    create(:response, approval: positive, status: :accepted)
    create(:response, approval: negative, status: :declined)
    login_as(hunter, scope: :hunter)

    visit root_path
    click_on 'Área do Headhunter'
    click_on 'Dev Java'
    click_on 'Encerrar vaga'

    expect(page).to_not have_css('span', text: 'Pendente')
    expect(page).to have_css('span', text: 'Rejeitado', count: 2)
    expect(page).to_not have_css('span', text: 'Aprovado')
    expect(page).to have_css('span', text: 'Contratado', count: 1)
    expect(page).to have_css('span', text: 'Recusado', count: 2)
  end
end
