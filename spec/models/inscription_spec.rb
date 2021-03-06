# frozen_string_literal: true

require 'rails_helper'

describe Inscription do
  describe '.user_has_a_profile' do
    it 'has a completed profile' do
      user = create(:user)
      create(:profile, user: user, status: 'complete')
      inscription = build(:inscription, user: user)

      inscription.valid?

      expect(inscription.errors).to be_empty
    end

    it 'has a semi-complete profile' do
      user = create(:user)
      create(:profile, user: user, status: 'incomplete')
      inscription = build(:inscription, user: user)

      inscription.valid?

      expect(inscription.errors).to be_empty
    end

    it 'has a pending profile' do
      user = create(:user)
      create(:profile, user: user, status: 'pending')

      inscription = build(:inscription, user: user)
      inscription.valid?

      expect(inscription.errors.full_messages).to \
        eq(['Candidato precisa preencher o perfil para poder se candidatar'])
    end

    it 'has no profile' do
      user = create(:user)
      inscription = build(:inscription, user: user)

      inscription.valid?

      expect(inscription.errors.full_messages).to \
        eq(['Candidato precisa preencher o perfil para poder se candidatar'])
    end
  end

  describe '.job_has_uniq_users' do
    it 'and is the first inscription at the job' do
      user = create(:user)
      create(:profile, user: user, status: 'complete')
      inscription = build(:inscription, user: user)

      expect(inscription.valid?).to be_truthy
    end

    it 'and its already inscribed to the job' do
      user = create(:user)
      create(:profile, user: user, status: 'complete')
      job = create(:job)
      create(:inscription, user: user, job: job)
      inscription = build(:inscription, user: user, job: job)

      job.reload
      inscription.valid?

      expect(inscription.errors.full_messages).to eq(['Candidato já inscrito'])
    end

    it 'and has another candidate already applied to the job' do
      user = create(:user)
      another_user = create(:user, email: 'another@email.com')
      create(:profile, user: user, status: 'complete')
      create(:profile, user: another_user, status: 'complete')
      job = create(:job)
      create(:inscription, user: user, job: job)
      inscription = build(:inscription, user: another_user, job: job)

      job.reload
      inscription.valid?

      expect(inscription.errors).to be_empty
    end

    it 'and candidate have already applied for other job of the same hunter' do
      user = create(:user)
      create(:profile, user: user, status: 'complete')
      hunter = create(:hunter)
      job = create(:job, hunter: hunter)
      another_job = create(:job, title: 'Other Job', hunter: hunter)
      create(:inscription, user: user, job: another_job)
      inscription = build(:inscription, user: user, job: job)

      job.reload
      inscription.valid?

      expect(inscription.errors).to be_empty
    end

    it 'and candidate have already applied for job of different hunter' do
      user = create(:user)
      create(:profile, user: user, status: 'complete')
      hunter = create(:hunter)
      another_hunter = create(:hunter, email: 'another@hunter.com')
      job = create(:job, hunter: hunter)
      another_job = create(:job, title: 'Other Job', hunter: another_hunter)
      create(:inscription, user: user, job: another_job)
      inscription = build(:inscription, user: user, job: job)

      job.reload
      inscription.valid?

      expect(inscription.errors).to be_empty
    end
  end

  describe '.deadline_not_past' do
    it 'on the exact same date as deadline' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, deadline: 1.day.from_now)
      travel_to(1.day.from_now) do
        inscription = build(:inscription, job: job, user: user)

        inscription.valid?

        expect(inscription.errors).to be_empty
      end
    end

    it 'one day past the deadline' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, deadline: 1.day.from_now)
      travel_to(2.day.from_now) do
        inscription = build(:inscription, job: job, user: user)

        inscription.valid?

        expect(inscription.errors.full_messages).to eq(['Prazo acabou'])
      end
    end
  end

  describe '.job_is_active' do
    it 'success' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, deadline: 1.day.from_now)
      inscription = build(:inscription, job: job, user: user)

      inscription.valid?

      expect(inscription.errors).to be_empty
    end

    it 'and its inactive' do
      user = create(:user)
      create(:profile, user: user)
      job = create(:job, deadline: 1.day.from_now, status: :inactive)
      inscription = build(:inscription, job: job, user: user)

      inscription.valid?

      expect(inscription.errors.full_messages).to eq(['Vaga está inativa'])
    end
  end
end
