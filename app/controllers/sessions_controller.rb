class SessionsController < ApplicationController
  # skip_before_filter :verify_authenticity_token, if: :json_request?
  # GET /login
  #
  def login
    @render_club_photo = true
  end

  #POST login
  def create #creating session
    user = User.find_by(username: params[:username])

    # If the user exists AND the password entered is correct.
    #user.authenticate is created by the call to has_secure_password in the model
    if user && user.authenticate(params[:password])
      log_in user  # Save the user id inside the session, i.e. the browser cookie.

      if params[:remember_me] == 'on'
        remember user
      else
        forget user
      end
      respond_to do |format|
        format.html { redirect_to '/songs' }
        format.json { render json: ':message : "go card welcome"' }
      end
    else
      # If user's login doesn't work, send them back to the login form.
      @render_club_photo = true
      @error = true
      respond_to do |format|
        format.html { render 'login' }
        format.json { render json: ':message : "login error"' }
      end # Save the user id inside the browser cookie. This is how we keep the user
    end
  end
  # GET /logout

  def destroy
    log_out

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render json: 'So long for now' }
    end

  end
end

# get '/session_viewer' do
#   session.inspect
# end
#
# get '/users' do
#
# end
#
# get '/users/new' do
#   @render_club_photo = true
#   session[:current_user_id] = nil
#   erb :signup
# end
#
# get '/users/:id' do #get specific user
# end
#
# get '/users/:id/edit' do #send form for editing user
# end
#
# put '/users/:id' do #update a user's record
#
# end
#
# delete '/users/:id' do #delete a user's record
#
# end
#
#
#
#
# post '/users' do
#   @render_club_photo = true
#   if params[:password] == params[:verify_password]
#     new_user = User.new(
#         username: params[:username],
#         email: params[:email],
#         phone_number: params[:phone_number],
#         password: params[:password])
#     new_user.password = params[:password]
#     if new_user.save
#       session[:current_user_id] = new_user.id
#       @songs = Song.all
#       erb :song_search
#
#     else
#       @signup_errors = new_user.errors.messages
#       erb :signup
#     end
#   else
#     @error = "Your passwords don't match."
#     erb :signup
#   end
# end
#
#
# get '/users/index' do
#   erb :show_sots
#
# end

