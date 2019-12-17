# frozen_string_literal: true

require 'rails_helper'

describe JobHelper, type: :helper do
  describe '#job_attribute_positions_hash' do
    it 'returns the translated attribute name' do
      expect(helper.job_attribute_positions_hash)
        .to eq(intern: 'Estagiário', junior: 'Júnior', middle: 'Pleno',
               senior: 'Sênior', expert: 'Especialista', manager: 'Diretor')
    end
  end
end
