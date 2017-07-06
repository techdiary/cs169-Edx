class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #get sorting type from user or from session
    sort = params[:sort] || session[:sort]
    case sort
      when 'title'
        ordering, @title_header = {:title => :asc}, 'hilite'
      when 'release_date'
        ordering, @release_header = {:release_date => :asc}, 'hilite'
    end

    #Import rating from Movie model
    @all_ratings = Movie.all_rating
    #get rating from user by parameter or session or it can be blank even
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    #If no rating options were selected, map all rating available to this variable.
    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating,1]}]
    end

    #If selected sort and rating are not equal to session values
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      # declare session hash keys with available values
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      #store previous page flash
      flash.keep
      #return parameters to website and do nothing
      redirect_to movies_path(:sort => sort, :ratings => @selected_ratings) and return
    end
    # @movies = Movie.order(ordering)
    @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
