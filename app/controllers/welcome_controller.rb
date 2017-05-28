class WelcomeController < ApplicationController

  def index
    flash[:notice] = "晚上好"
  end
end
