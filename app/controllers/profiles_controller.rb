# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate
  before_action :authenticate_user_only, only: %i[index new create edit update
                                                  approval]
  before_action :user_have_profile, only: %i[new create]
  before_action :user_dont_have_profile, only: %i[show index]
  def index
    @profile = current_user.profile
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.set_status
    if @profile.save
      flash[:notice] = 'Perfil salvo com sucesso'
      redirect_to profiles_path
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
    @profile = current_user.profile
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.set_status
    if @profile.update(profile_params)
      flash[:notice] = 'Perfil atualizado com sucesso'
      redirect_to profiles_path
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def approvals
    @inscriptions = Inscription.where('user_id= ? AND (status= ? OR status= ?)',
                                      params[:id], Inscription.statuses[:hired],
                                      Inscription.statuses[:approved])
    @jobs = Job.where(id: @inscriptions.select(:job_id))
    render 'approvals/index'
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
