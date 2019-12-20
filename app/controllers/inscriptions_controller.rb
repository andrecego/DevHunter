# frozen_string_literal: true

class InscriptionsController < ApplicationController
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
    if @inscription.job.hunter == current_hunter
      @inscription.update(starred: !@inscription.starred?)
      redirect_to job_path(@inscription.job)
    else
      flash[:alert] = 'Você não tem essa permissão'
      redirect_to jobs_path
    end
  end
  
end
