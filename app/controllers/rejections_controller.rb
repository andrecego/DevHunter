# frozen_string_literal: true

class RejectionsController < ApplicationController
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
      @user = @inscription.user
      render :new
    end
  end

  private

  def rejection_params
    params.require(:rejection).permit(:feedback)
          .merge(inscription: @inscription)
  end
end
