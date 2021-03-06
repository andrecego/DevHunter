# frozen_string_literal: true

class ApprovalsController < ApplicationController
  before_action :authenticate_hunter_only, only: %i[new create]
  def new
    @approval = Approval.new
    @inscription = Inscription.find(params[:inscription_id])
  end

  def create
    @inscription = Inscription.find(params[:inscription_id])
    @approval = Approval.new(approval_params)
    if @approval.save
      @inscription.approved!
      flash[:notice] = 'Proposta enviada com sucesso'
      redirect_to @inscription.job
    else
      flash[:error] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @approval = Approval.find(params[:id])
    @inscription = @approval.inscription
    @job = @inscription.job
    render 'jobs/show'
  end

  private

  def approval_params
    params.require(:approval).permit(:start_date, :wage, :aid)
          .merge(inscription: @inscription)
  end
end
