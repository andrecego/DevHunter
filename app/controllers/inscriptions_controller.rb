# frozen_string_literal: true

class InscriptionsController < ApplicationController
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
end
