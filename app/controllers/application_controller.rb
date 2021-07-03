# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # helper Webpacker::Helper
  before_action :authenticate_user!
  include Pundit

end
