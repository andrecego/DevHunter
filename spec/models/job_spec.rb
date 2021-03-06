# frozen_string_literal: true

require 'rails_helper'

describe Job do
  describe '.max_wage_cannot_be_less_than_min_wage' do
    it 'success' do
      job = build(:job, min_wage: 500, max_wage: 1000)

      job.valid?

      expect(job.errors).to be_empty
    end

    it 'max wage less than min wage' do
      job = build(:job, min_wage: 1500, max_wage: 1000)

      job.valid?

      expect(job.errors.full_messages).to eq(['Salário Máximo não pode ser ' \
                                              'menor que Salário Mínimo'])
    end

    it 'max wage equal to min wage' do
      job = build(:job, min_wage: 500, max_wage: 500)

      job.valid?

      expect(job.errors).to be_empty
    end

    it 'max wage must exist' do
      job = build(:job, min_wage: 1500, max_wage: '')

      job.valid?

      expect(job.errors.full_messages).to include('Salário Máximo não pode ' \
                                                  'ficar em branco')
    end

    it 'min wage must exist' do
      job = build(:job, min_wage: '', max_wage: 2000)

      job.valid?

      expect(job.errors.full_messages).to include('Salário Mínimo não pode ' \
                                                  'ficar em branco')
    end
  end

  describe '.deadline_must_be_greater_than_today' do
    it 'success' do
      job = build(:job, deadline: Date.tomorrow)

      job.valid?

      expect(job.errors.full_messages).to be_empty
    end

    it 'deadline cant be in the past' do
      job = build(:job, deadline: 5.days.ago)

      job.valid?

      expect(job.errors.full_messages).to eq(['Data limite não pode ser menor' \
                                              ' que hoje'])
    end

    it 'deadline cant be today' do
      job = build(:job, deadline: Date.today)

      job.valid?

      expect(job.errors.full_messages).to eq(['Data limite não pode ser menor' \
                                              ' que hoje'])
    end
  end
end
