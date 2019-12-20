# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user_only
  def index; end
end
