class ReviewsController < ApplicationController
    before_filter :has_moviegoer_and_movie, :only => [:new, :create]
    protected
    def has_moviegoer_and_movie
        unless current_moviegoer
            flash[:warning] = 'You must be logged in to create a review.'
            redirect_to '/moviegoers/sign_in'
        end
        unless (@movie = Movie.where(:id => params[:movie_id]))
            flash[:warning] = 'Review must be for an existing movie.'
            redirect_to movies_path
        end
    end

    public

    def index
        id = params[:movie_id]
        @movie = params[:movie_id]
        @all_reviews = Review.where(:movie_id => id)
    end

    def new
        id = params[:movie_id]
        @movie = Movie.find(id)
        @review = @movie.reviews.build
    end

    def create
        @movie = Movie.find(params[:movie_id]) # Find the movie by its ID
        if @movie
          review = @movie.reviews.build(reviews_params) # Build a new review associated with the movie
          review.moviegoer = current_moviegoer # Set the moviegoer for the review
      
          if review.save
            redirect_to movie_path(@movie), notice: 'Review was successfully created.'
          else
            render :new
          end
        else
          # Handle the case where the movie is not found, e.g., display an error message or redirect to an error page.
        end
      end
    
    private

    def reviews_params
        params.require(:review).permit(:comments, :potatoes)
    end
end
