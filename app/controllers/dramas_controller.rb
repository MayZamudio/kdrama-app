class DramasController < ApplicationController
  before_action :set_drama, only: %i[ show edit update destroy ]

  # GET /dramas or /dramas.json
  def index
    @dramas = Drama.all.order(created_at: :desc)
  end

  # GET /dramas/1 or /dramas/1.json
  def show
  end

  # GET /dramas/new
  def new
    @drama = Drama.new
  end

  # GET /dramas/1/edit
  def edit
  end

  # POST /dramas or /dramas.json
  def create
    @drama = Drama.new(drama_params)

    respond_to do |format|
      if @drama.save
        format.html { redirect_to drama_url(@drama), notice: "Drama was successfully created." }
        format.json { render :show, status: :created, location: @drama }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drama.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dramas/1 or /dramas/1.json
  def update
    respond_to do |format|
      if @drama.update(drama_params)
        flash[:success] = "#{@drama.title} was successfully updated."
        format.html { redirect_to drama_url(@drama) }
        format.json { render :show, status: :ok, location: @drama }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drama.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dramas/1 or /dramas/1.json
  def destroy
    drama_title = @drama.title
    @drama.destroy

    respond_to do |format|
      format.html { 
        flash[:danger] = "#{drama_title} was successfully destroyed."
        redirect_to dramas_url 
      }
      format.json { head :no_content }
    end
  end

  def search_tmdb
    title = params[:title]
  
    if title.nil?
      render 'search'
    elsif title.blank?
      flash[:danger] = "Please fill in all required fields!"
      render 'search'
    else
      @search_results = Drama.find_in_tmdb(title)
      if @search_results.empty?
        flash[:danger] = "No dramas found with given parameters!"
        redirect_to search_tmdb_path
      else
        render 'search'
      end
    end
  end

  def add_drama
    @search_results = Drama.create!(drama_params)
    flash[:success] = "#{@search_results.title} was successfully added!"
    redirect_to search_tmdb_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drama
      @drama = Drama.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drama_params
      params.require(:drama).permit(:title, :overview, :air_date, :rating, :backdrop, :poster, :profile_path, :actor_name, :media_type, :country)
    end
end
