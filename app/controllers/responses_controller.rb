# frozen_string_literal: true

class ResponsesController < ApplicationController
  def new
    @inscription = Inscription.find(params[:inscription_id])
    @approval = Approval.find(params[:approval_id])
    @response = Response.new
  end

  def create
    @approval = Approval.find(params[:approval_id])
    @response = Response.new(params.require(:response).permit(:comment)
                                   .merge(approval: @approval))
    if @response.save
      accept_job
      flash[:success] = 'Proposta aceita'
    else
      flash[:error] = 'Apenas uma resposta por proposta'
    end
    redirect_to root_path
  end

  private

  def accept_job
    @response.accepted!
    @approval.inscription.hired!
  end
end
