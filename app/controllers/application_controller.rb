# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def authenticate_only_hunter
    return if current_hunter

    flash[:alert] = 'Você precisa ser um Headhunter para ver esta área'
    redirect_to root_path
  end

  def authenticate_only_user
    return if current_user

    flash[:alert] = 'Você precisa ser um Candidato para ver esta área'
    redirect_to root_path
  end
end
