class WelcomeController < ApplicationController

  def index
    if logged_in?
      redirect_to songs_url
    else

      @render_club_photo = true

      render "sessions/login"
    end
    #now render index.html.erb
    #   respond_to do |format|
    #       format.html { render :index }
    #       format.json { return_msg= {message: "Welcome"}; render json: return_msg }
    #     end
  end
end
