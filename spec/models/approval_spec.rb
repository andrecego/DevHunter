# frozen_string_literal: true

require 'rails_helper'

describe Approval do
  describe '.wage_more_than_job_min_wage' do
    it 'success' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, min_wage: 2000)
      inscription = create(:inscription, job: job, user: user)
      approval = build(:approval, inscription: inscription, wage: 2001)

      approval.valid?

      expect(approval.errors).to be_empty
    end

    it 'wage is empty' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, min_wage: 2000)
      inscription = create(:inscription, job: job, user: user)
      approval = build(:approval, inscription: inscription, wage: '')

      approval.valid?

      expect(approval.errors.full_messages).to eq(['Salário não pode ficar em' \
                                                   ' branco'])
    end

    it 'wage is equal to min wage' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, min_wage: 2000)
      inscription = create(:inscription, job: job, user: user)
      approval = build(:approval, inscription: inscription, wage: 2000)

      approval.valid?

      expect(approval.errors).to be_empty
    end

    it 'wage is less than min wage' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, min_wage: 2000)
      inscription = create(:inscription, job: job, user: user)
      approval = build(:approval, inscription: inscription, wage: 1999)

      approval.valid?

      expect(approval.errors.full_messages).to eq(['Salário não pode ser ' \
                                                   'menor que R$: 2000'])
    end
  end
end
