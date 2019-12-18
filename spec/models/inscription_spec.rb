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
end
