# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_only_hunter, only: :create
  def create
    @profile = Profile.find(params[:profile_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comentário postado com sucesso'
      redirect_to profile_path(@profile)
    else
      flash[:error] = 'Algo deu errado'
      render 'profiles/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(profile: @profile,
                                                 hunter: current_hunter)
  end
end
