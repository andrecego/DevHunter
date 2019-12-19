# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate  
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
end
