class MoviesController < ApplicationController
    def create
        #@movie = Movie.create!(params[:movie]) #old way
        @movie = Movie.create!(movie_params)  # new way
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movies_path
    end
    def index
        @movies = Movie.all
    end
    def show
        id = params[:id] # retrieve movie ID from URI route
        @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.html.haml by default
    end
    def new
     @movie = Movie.new
    # default: render 'new' template
    end 
    
    private
    def movie_params
        params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
    
    def edit
    @movie = Movie.find params[:id]
    end

    def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
     respond_to do |client_wants|
        client_wants.html {  redirect_to movie_path(@movie)  } # as before
        client_wants.xml  {  render :xml => @movie.to_xml    }
        end
    end
    
    def destroy
     @movie = Movie.find(params[:id])
     @movie.destroy
     flash[:notice] = "Movie '#{@movie.title}' deleted."
     redirect_to movies_path
    end
end

