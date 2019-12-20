# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate
  before_action :user_have_profile, only: %i[new create]
  before_action :user_dont_have_profile, only: %i[show index]
  def index
    @profile = Profile.find(current_user.id)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.set_status
    if @profile.save
      flash[:notice] = 'Perfil salvo com sucesso'
      redirect_to @profile
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @comment = Comment.new
    @comments = @profile.comments
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  private

  def profile_params
    params.require(:profile)
          .permit(:full_name, :social_name, :birthdate, :picture, :experience,
                  :qualifications, :description)
          .merge(user: current_user)
  end

  def user_dont_have_profile
    return if current_hunter || current_user.profile

    flash[:notice] = 'Você ainda não tem um perfil'
    redirect_to new_profile_path
  end

  def user_have_profile
    return if current_user.profile.blank?

    flash[:error] = 'Você já tem um perfil'
    redirect_to root_path
  end
end
