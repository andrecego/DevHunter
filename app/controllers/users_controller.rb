# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user_only
  def approvals
    @inscriptions = Inscription.where(user: params[:id], status: 'approved')
    @jobs = Job.where(id: @inscriptions.select(:job_id))
    render 'approvals/index'
  end
end
