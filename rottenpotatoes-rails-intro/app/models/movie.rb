class Movie < ActiveRecord::Base
  def self.all_rating
    %w(G PG PG-13 R)
  end
end
