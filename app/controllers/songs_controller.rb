class SongsController < ApplicationController
  before_filter :authorize_user

# GET /songs
  def index
    @songs = @songs ||= Song.all
    # @songs = Song.all
  end

#POST /songs/search
  def search

    options_string, options_params = build_search
    @songs = Song.where(options_string, *options_params)

    render "songs/index"
  end

  def simple_search
    options_string, options_params = build_search
    @songs = Song.where(options_string, *options_params)
    @performance_id = params["performance_id"]
    render "simple_search_results", :layout => false
    #this was called from ajax and will return the data, simple_search.html.erb to performances.js
  end

# GET /songs/1
# GET /songs.json
# GET /songs/new

  def show
    @song = current_song
    @amazonAWS_path = "#{ENV['AWS_SOTS_DIR_PATH']}#{@song.song_number}"
    # @amazonAWS_path = "http://s3-us-west-1.amazonaws.com/stfyc-sots/#{@song.song_number}"
    render "songs/show"
  end

  def new
    @song = Song.new
    @song.song_number = Song.last.song_number + 1
  end

  def edit
    @song = current_song
    @song_number = @song.song_number
    render "songs/show" #same code for both

  end

  def create
    song_hash= song_params

    @render_club_photo = false
    handle_pdf_mp3(song_hash)

    # File.open(Rails.root.join("public", "SOTS_Songs", "#{@song.song_number}.pdf").to_s)
    respond_to do |format|

      if @song = Song.create(song_hash)
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song } # render(json: {})
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    song_hash= song_params

    handle_pdf_mp3(song_hash)

    @song = current_song
    @render_club_photo = false
    respond_to do |format|
      if @song.update(song_hash)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render json: @song } # render(json: {})
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @song = current_song
    filename = Rails.root.join("public", "SOTS_Songs", "#{@song.song_number}.pdf").to_s
    File.delete(filename) if File.exist?(filename)


    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_path, notice: 'Song was deleted.' }
      format.json { render json: 'Song was deleted.' } # render(json: {})
    end
  end


  private
# Use callbacks to share common setup or constraints between actions.
  def current_song
    Song.find(params[:id])
  end


# Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    params.require(:song).permit(:title, :voicing, :composer, :arranger_one, :arranger_two, :category, :larger_work, :song_number, :pdf_file, :mp3_file, :performance_id)
  end

#if nil, don't save
# the name of the pdf file as stored follows Herb's original naming convention
# where the pdf filename is a number.  For an existing song, the original number
# is pulled from the db.  For a new song, the next number in the sequence
# is generated in #new.
#create the path name out of for our local storage, then save the pdf and mp3 data
#then try to save it to Amazon
#stored in song_hash in those files.

#https://devcenter.heroku.com/articles/s3
  def write_Amazon_file(filename, file_path)
    require 'aws-sdk'


    s3 = Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
        region: 'us-west-1'
    )

    obj = s3.bucket('stfyc-sots').object(filename)
    obj.upload_file(file_path, acl:'public-read')
  end

  def handle_pdf_mp3(song_hash)
    song= (song_hash[:song_number]).to_s
    path = Rails.root.join("public", "SOTS_Songs", song)
    pdf_filename = path.to_s + ".pdf"
    mp3_filename = path.to_s + ".mp3"

    pdf_file_object = song_hash[:pdf_file]
    mp3_file_object = song_hash[:mp3_file]

    if !pdf_file_object.nil?
      File.open(pdf_filename, 'wb') do |f|
        f.write pdf_file_object.read
        write_Amazon_file song + ".pdf", pdf_filename
      end
    end
    if !mp3_file_object.nil?
      File.open(mp3_filename, 'wb') do |f|
        f.write mp3_file_object.read
        write_Amazon_file song + ".mp3", mp3_filename

      end
    end
    song_hash.delete(:pdf_file) #remove the filename from the hash (not a legal db fieldname)
    song_hash.delete(:mp3_file) #remove the filename from the hash
  end


  def build_search
    options_string = ""
    options_params = []

    #now build the Active Record search string
    #search_string will be like:  "title ilike ? and composer ilike ? and voicing ilike ?"
    #search options will be like: ["%rio%", "%bart%", "%TTBB%"]

    #probably need to call song_params here!!!
    params.each do |key, value|
      next if ["utf8", "authenticity_token", "commit", "controller", "action", "performance_id"].include? key

      if value.length != 0
        if options_string.length != 0
          options_string << " and "
        end
        options_string << key.to_s + " ilike ?"
        options_params << '%' + value + '%'
      end
    end
    return [options_string, options_params]
  end
end