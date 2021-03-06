# frozen_string_literal: true

class Hunter < ApplicationRecord
  has_many :inscriptions
  has_many :jobs, through: :inscriptions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
