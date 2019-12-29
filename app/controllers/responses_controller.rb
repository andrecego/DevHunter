# frozen_string_literal: true

class ResponsesController < ApplicationController
  before_action :authenticate_user_only
  def new
    @inscription = Inscription.find(params[:inscription_id])
    @approval = Approval.find(params[:approval_id])
    @response = Response.new
  end

  def create
    @approval = Approval.find(params[:approval_id])
    @response = Response.new(params.require(:response).permit(:comment)
                                   .merge(approval: @approval))
    if params[:accept]
      accept_job
    elsif params[:decline]
      decline_job
    end
  end

  private

  def accept_job
    if @response.save
      hired
      flash[:success] = 'Proposta aceita'
    else
      flash[:error] = 'Apenas uma resposta por proposta'
    end
    redirect_to root_path
  end

  def hired
    @response.accepted!
    @approval.inscription.hired!
    current_user.inscriptions.map do |inscription|
      inscription.declined! if inscription.approved?
      rejection(inscription) if inscription.pending?
    end
  end

  def rejection(inscription)
    Rejection.create(
      feedback: 'Contratado para outra vaga', inscription: inscription
    )
    inscription.rejected!
  end

  def decline_job
    if @response.save
      @response.declined!
      @approval.inscription.declined!
      flash[:success] = 'Proposta recusada'
    else
      flash[:error] = 'Apenas uma resposta por proposta'
    end
    redirect_to inscriptions_path
  end
end
