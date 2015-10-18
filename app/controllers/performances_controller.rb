class PerformancesController < ApplicationController
  before_filter :authorize_user

  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  # GET /performances
  # GET /performances.json
  def index

    @performances = Performance.all
  end

  # GET /performances/1
  # GET /performances/1.json
  def show
    id = params[:id]
    @performance = Performance.find(params[:id])

  end

  # GET /performances/new
  def new
    @performance = Performance.new
  end

  # GET /performances/1/edit
  def edit
    @performance = Performance.find(params[:id])
  end

  # POST /performances
  # POST /performances.json
  def create
    @performance = Performance.new(performance_params)

    respond_to do |format|
      if @performance.save
        format.html { redirect_to @performance, notice: 'Performance was successfully created.' }
        format.json { render json: @performance }# render(json: {})
      else
        format.html { render :new }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performances/1
  # PATCH/PUT /performances/1.json
  def update
    @performance = Performance.find(params[:id])
    respond_to do |format|
      if @performance.update(performance_params)
        format.html { redirect_to @performance, notice: 'Performance was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance }
      else
        format.html { render :edit }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performances/1
  # DELETE /performances/1.json
  def destroy
    @performance.destroy
    respond_to do |format|
      format.html { redirect_to performances_url, notice: 'Performance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_song_to_performance
    song_id = params["song_id"].to_i
    song= Song.find(song_id)

    performance_id = params["performance_id"].to_i
    performance = Performance.find(performance_id)

    performance.songs << song
    redirect_to performance
  end

  def delete_song_from_performance
    song_id = params["song_id"].to_i
    song= Song.find(song_id)

    performance_id = params["performance_id"].to_i
    performance = Performance.find(performance_id)

    performance.songs.delete(song)
    redirect_to performance

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_performance
    @performance = Performance.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def performance_params
   params.require(:performance).permit(:title, :date, :performance_time, :call_time, :location, :event_leader, :leader_phone)
  end
end
