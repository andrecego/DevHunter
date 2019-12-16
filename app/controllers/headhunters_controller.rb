# frozen_string_literal: true

class HeadhuntersController < ApplicationController
  before_action :authenticate_only_hunter
  before_action :authenticate_current_hunter, only: :show

  def index
    @jobs = Job.where(hunter: current_hunter)
  end

  def show
    @job = Job.find(params[:id])
  end

  private

  def authenticate_current_hunter
    return if Job.find(params[:id]).hunter == current_hunter

    flash[:alert] = 'Essa não é uma vaga sua'
    redirect_to root_path
  end
end
