Step defination for director features

Given /the following movies exist/ do |movie_table|
  movie_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_name, director_name|
  page.should have_content(director_name)
end
