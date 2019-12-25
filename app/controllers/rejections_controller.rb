# frozen_string_literal: true

class RejectionsController < ApplicationController
  before_action :authenticate_hunter_only, only: %i[new create]
  before_action :current_hunter_or_user, only: :show
  def new
    @inscription = Inscription.find(params[:inscription_id])
    @rejection = Rejection.new
    @user = @inscription.user
  end

  def create
    @inscription = Inscription.find(params[:inscription_id])
    @rejection = Rejection.new(rejection_params)
    if @rejection.save
      @inscription.rejected!
      flash[:notice] = 'Candidato rejeitado com sucesso'
      redirect_to @inscription.job
    else
      flash[:error] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @rejection = Rejection.find(params[:id])
    @job = @inscription.job
    render 'jobs/show'
  end

  private

  def rejection_params
    params.require(:rejection).permit(:feedback)
          .merge(inscription: @inscription)
  end

  def current_hunter_or_user
    @inscription = Inscription.find(params[:inscription_id])
    return if @inscription.job.hunter == current_hunter
    return if @inscription.user == current_user

    flash[:error] = 'Você não tem essa permissão'
    redirect_to root_path
  end
end
