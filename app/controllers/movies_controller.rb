class MoviesController < ApplicationController
  def index
    @movies = Movie
    @movies = @movies.with_title_like(params[:title]) unless params[:title].blank?    
    @movies = @movies.with_director_like(params[:director]) unless params[:director].blank?
    unless params[:runtime_in_minutes].blank?
      if params[:runtime_in_minutes] == "90"
        @movies = @movies.under_ninety(params[:runtime_in_minutes])
      elsif params[:runtime_in_minutes] == "120"
        @movies = @movies.between_ninety_and_onetwenty(params[:runtime_in_minutes])
      else
        @movies = @movies.over_onetwenty(params[:runtime_in_minutes])
      end
    end
    @movies = @movies.all.order(:runtime_in_minutes)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end
end
