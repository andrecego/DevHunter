# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'candidato@candidato.com' }
    password { 'senha123' }
  end
end
