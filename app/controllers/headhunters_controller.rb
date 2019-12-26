# frozen_string_literal: true

class HeadhuntersController < ApplicationController
  before_action :authenticate_hunter_only
  before_action :authenticate_current_hunter, only: :show

  def index
    @jobs = Job.where(hunter: current_hunter)
  end
end
