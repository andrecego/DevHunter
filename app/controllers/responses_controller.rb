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
    return unless @response.save

    flash[:success] = 'Proposta aceita'
    redirect_to root_path
  end
end
