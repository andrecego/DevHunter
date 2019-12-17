# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def signup
    @user = User.new
    @hunter = Hunter.new
  end

  def signin
    @user = User.new
    @hunter = Hunter.new
  end
end
