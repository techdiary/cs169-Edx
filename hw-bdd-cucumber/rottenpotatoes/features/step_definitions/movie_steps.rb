# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body =~ /#{e1}.+#{e2}/
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # rating_list = rating_list.gsub(' ','').split(',')
    #  rating_list.each do |rating|
    #     {I uncheck "#{rating}"} We will have to start each loop again in order to do I check #{ratings}
    # end
  if uncheck == "un"
    rating_list.split(", ").each { |x| I uncheck "ratings_#{x}" }
  else
    rating_list.split(", ").each { |x| I check "ratings_#{x}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  row = page.all('#movies tbody tr').size
  row == Movie.count()
end
