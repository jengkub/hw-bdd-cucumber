class Movie < ActiveRecord::Base

  # place a copy of the following line anywhere inside the Movie class
  #  AND inside the Moviegoer class (idiomatically, it should go right
  #  after 'class Movie' or 'class Moviegoer'):
  has_many :reviews
  
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end
  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end
end
