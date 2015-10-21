class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    return if !current_user_authorized?(options = {:task => :member_task})
    #current_user_authorized? sets up redirect
    @user = User.find_by(id: params[:id])

    #render show.html.erb
  end

  # GET /users/1/edit
  def edit
    return if !current_user_authorized? (options = {user_id: params[:id],
                                                    :task => :edit_profile})
    #current_user_authorized? sets up redirect

    @user= User.find_by(id: params[:id])

  end
  # GET /users/new
  # assumes views/users/new.html.erb
  def new
    #seed some admin level here, for now can't see the menu
    @render_club_photo = true
    session[:current_user_id] = nil
    @user = User.new
  end



  # POST /users
  # POST /users.json
  def create
    @render_club_photo = true

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user

        # format.html { redirect_to "/users/#{@user.id}", notice: 'User was successfully created.' }
        format.html { redirect_to @user, notice: 'User was successfully created.' }

        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to new_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    return if !current_user_authorized? (options =
                                            {user_id: params[:id],
                                             :task => :edit_profile})
    @user= current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    return if !current_user_authorized? (options =
                                            {user_id: params[:id],
                                             :task => :delete_user})
    @user= User.find_by(id: params[:id])
    @user.destroy

    if current_user != @user
      redirect_to users_path
    else #kill session
      session[:current_user_id] = nil
      respond_to do |format|
        format.html { redirect_to roots_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end

    end
  end

  #GET /users/change_password/1
  #goes through user#update
  def change_password
    @user = authorize_user
    # render change_password.html.erb
  end

  # This is handled by update
  # #POST /users/update_password/1
  # def update_password
  #
  # end


  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :voice, :username, :email, :phone_number, :password, :password_confirmation)
  end

end
