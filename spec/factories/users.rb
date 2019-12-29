# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "candidato#{Random.rand(1000)}@candidato.com" }
    password { 'senha123' }
  end
end
