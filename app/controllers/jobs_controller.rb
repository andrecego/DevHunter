# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :authenticate_hunter_only, only: %i[new create]
  before_action :authenticate, only: %i[index show]

  def index
    @jobs = if current_hunter
              Job.where(hunter: current_hunter)
            else
              Job.all
            end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = 'Vaga registrada com sucesso'
      redirect_to headhunter_path(@job)
    else
      flash[:alert] = 'Algo deu errado'
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @inscriptions = @job.inscriptions.order(starred: :desc)
  end

  def search
    @jobs = Job.where('title like ?', "%#{params[:q]}%")
               .or(Job.where('description like ?', "%#{params[:q]}%"))
    @jobs = @jobs.select { |x| x.hunter == current_hunter } if current_hunter
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :skills, :position,
                                :min_wage, :max_wage, :deadline, :location)
          .merge(hunter: current_hunter)
  end
end
