class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize_user
    @user = User.find(params[:id])

    #render show.html.erb
  end

  # GET /users/new
  # assumes views/users/new.html.erb
  def new
    #seed some admin level here, for now can't see the menu
    @render_club_photo = true
    session[:current_user_id] = nil
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize_user
    @user = User.find(params[:id])

    #don't let user edit someone else's account.
    #render edit.html.erb
  end

  # POST /users
  # POST /users.json
  def create
    #need some authorization here
    @user = User.new(user_params)
    @render_club_photo = true
    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { redirect_to "/users/#{@user.id}", notice: 'User was successfully created.' }
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
    @user = authorize_user

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
    @user = authorize_user

    @user.destroy
    session[:current_user_id] = nil
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #GET /users/change_password/1
  #goes through user#update
  def change_password
    @user = authorize_user
   # render change_password.html.erb
  end

  #POST /users/update_password/1
  def update_password

  end


  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :voice, :username, :email, :phone_number, :password, :password_confirmation)
  end
end
