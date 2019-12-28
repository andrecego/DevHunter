# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user_only
  def approvals
    @inscriptions = Inscription.where('user_id= ? AND (status= ? OR status= ?)',
                                      params[:id], Inscription.statuses[:hired],
                                      Inscription.statuses[:approved])
    @jobs = Job.where(id: @inscriptions.select(:job_id))
    render 'approvals/index'
  end
end
