# frozen_string_literal: true

class InscriptionsController < ApplicationController
  before_action :check_hunter, only: :star
  def index
    @inscriptions = Inscription.where(user: current_user)
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
    if @inscription.update(starred: !@inscription.starred?)
      flash[:notice] = 'Favoritado com sucesso'
      redirect_to job_path(@inscription.job)
    else
      flash[:alert] = 'Algo deu errado'
      redirect_to jobs_path
    end
  end

  private

  def check_hunter
    @inscription = Inscription.find(params[:id])
    return if @inscription.job.hunter == current_hunter

    flash[:alert] = 'Você não tem essa permissão'
    redirect_to jobs_path
  end
end
