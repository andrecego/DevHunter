# frozen_string_literal: true

require 'rails_helper'

describe Profile do
  describe 'must_be_older_than_fourteen_years_old' do
    it 'success' do
      profile = build(:profile, birthdate: 15.years.ago)

      profile.valid?

      expect(profile.errors).to be_empty
    end

    it 'and its exactly 14 years old' do
      profile = build(:profile, birthdate: 14.years.ago)

      profile.valid?

      expect(profile.errors).to be_empty
    end

    it 'and its one day off 14 years old' do
      profile = build(:profile, birthdate: 14.years.ago + 1.day)

      profile.valid?

      expect(profile.errors.full_messages).to eq(['Você precisa ter mais que ' \
                                                  '14 anos'])
    end

    it 'and didnt fill the birthday' do
      profile = build(:profile, birthdate: '')

      profile.valid?

      expect(profile.errors.full_messages).to eq(['Data de Nascimento não ' \
                                                  'pode ficar em branco'])
    end
  end
end
