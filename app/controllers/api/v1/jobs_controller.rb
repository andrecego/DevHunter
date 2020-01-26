class Api::V1::JobsController < Api::V1::ApiController

  def show
    job = Job.find(params[:id])
    render json: job, status: :ok
  end

  def index
    jobs = Job.all
    render json: jobs, status: :ok
  end

  def create
    job = Job.create!(params.permit(:title, :description, :skills, :position,
                                    :min_wage, :max_wage, :deadline, :location, 
                                    :hunter_id))
    render json: job, status: :created
  end

  def update
    job = Job.find(params[:id])
    job.update!(params.permit(:title, :description, :skills, :position,
                              :min_wage, :max_wage, :deadline, :location, 
                              :hunter_id))
    render json: job, status: :ok
  end

  def destroy
    job = Job.find(params[:id])
    job.delete
    render json: { message: 'Vaga deletada com sucesso'}, status: :ok
  end
end