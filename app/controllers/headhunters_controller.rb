# frozen_string_literal: true

class HeadhuntersController < ApplicationController
  before_action :authenticate_only_hunter
  def index; end
end
