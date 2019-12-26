# frozen_string_literal: true

require 'rails_helper'

describe InscriptionsController do
  context 'check_hunter' do
    before(:each) do
      @user = create(:user)
      create(:profile, :with_picture, user: @user)
      @hunter = create(:hunter)
      job = create(:job, hunter: @hunter, title: 'Dentista')
      @inscription = create(:inscription, user: @user, job: job, starred: false)
    end

    it 'success' do
      sign_in(@hunter, scope: :hunter)

      put :star, params: { id: @inscription }
      @inscription.reload

      expect(@inscription.starred).to eq true
    end

    it 'isnt the same hunter' do
      @another_hunter = create(:hunter, email: 'another@hunter.com')
      sign_in(@another_hunter, scope: :hunter)

      put :star, params: { id: @inscription }
      @inscription.reload

      expect(@inscription.starred).to eq false
    end

    it 'is a user' do
      sign_in(@user, scope: :user)

      put :star, params: { id: @inscription }
      @inscription.reload

      expect(@inscription.starred).to eq false
    end
  end

  context 'create' do
    it 'as a hunter' do
      hunter = create(:hunter)
      job = create(:job, title: 'Marketing Digital', hunter: hunter)
      sign_in(hunter, scope: :hunter)

      post :create, params: { job_id: job, user_id: hunter }

      expect(Inscription.first).to eq nil
    end
  end
end
