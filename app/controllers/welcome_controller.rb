class WelcomeController < ApplicationController

  def index
    if !logged_in?

      @render_club_photo = true

      render "sessions/login"
    else
      render "index.html.erb"
    end
    #   respond_to do |format|
    #       format.html { render :index }
    #       format.json { return_msg= {message: "Welcome"}; render json: return_msg }
    #     end
  end
end
