# frozen_string_literal: true

class InscriptionsController < ApplicationController
  before_action :check_hunter, only: :star
  before_action :authenticate_user_only, only: %i[index create]
  def index
    @jobs = current_user.jobs.order(:deadline)
  end

  def create
    @inscription = Inscription.new(params.permit(:job_id, :user_id))
    if @inscription.save
      flash[:notice] = 'Você se candidatou com sucesso'
      redirect_to jobs_path
    else
      flash[:alert] = 'Erro ao se inscrever'
      @job = @inscription.job
      render 'jobs/show'
    end
  end

  def star
    @inscription = Inscription.find(params[:id])
    return unless @inscription.update(starred: !@inscription.starred?)

    flash[:success] = 'Favoritado com sucesso' if @inscription.starred?
    flash[:notice] = 'Desfavoritado com sucesso' unless @inscription.starred?
    redirect_to job_path(@inscription.job)
  end

  private

  def check_hunter
    @inscription = Inscription.find(params[:id])
    return if @inscription.job.hunter == current_hunter

    flash[:alert] = 'Você não tem essa permissão'
    redirect_to jobs_path
  end
end
