class Review < ActiveRecord::Base
    belongs_to :movie
    belongs_to :moviegoer
    validates :movie_id, :presence => true
    # can ALSO require that the referenced movie itself be valid
    #  in order for the review to be valid:
    validates_associated :movie
end