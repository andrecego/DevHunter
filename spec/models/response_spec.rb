# frozen_string_literal: true

require 'rails_helper'

describe Response do
  describe 'only_one_record' do
    before(:each) do
      user = create(:user, email: 'candidate@email.com')
      create(:profile, user: user)
      hunter = create(:hunter)
      job = create(:job, hunter: hunter, title: 'Estilista')
      inscription = create(:inscription, job: job, user: user)
      @approval = create(:approval, inscription: inscription, aid: 'VR e TR',
                                    wage: 2000, start_date: 7.days.from_now)
      inscription.approved!
    end

    it 'success' do
      response = build(:response, approval: @approval)

      response.valid?

      expect(response.errors).to be_empty
    end

    it 'already had one response' do
      approval = create(:response, approval: @approval)
      approval.accepted!
      response = build(:response, approval: @approval)

      response.valid?

      expect(response.errors.full_messages).to eq(['Apenas uma resposta por ' \
                                                   'inscrição'])
    end
  end
end
