Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

#And /^I should see "'([^']*)' has no director info"$/ do | movie_title|
#  movie = Movie.find_by_title(movie_title)
#  rows = page.all("td[2]", :text => /^#{movie_title.strip}$/)
#  debugger
#end

Given /^I am on the details page for "([^"]*)"$/ do |movie_title|
  movie = Movie.find_by_title(movie_title)
  visit movie_path(movie)
end

When /^I go to the edit page for "([^"]*)"$/ do |movie_title|
  movie = Movie.find_by_title(movie_title)
  visit edit_movie_path(movie)
end

Then /^(?:|I )should see "(.+)"$/ do |text|
  case text
  when /has no director info/
    result= /^'([^']*)' has no director info$/.match(text)
    movie_title=result[1]
    movie = Movie.find_by_title(movie_title)
    rows = page.all("td[3]", :text => /^$/)
    assert_equal rows.size, 1
  else
    assert page.has_content?(text)
  end
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, director_name|
  movie = Movie.find_by_title(movie_title)
  visit movie_path(movie)
  assert page.has_content?(director_name)
end

Then /^I should be on the Similar Movies page for "([^"]*)"$/ do |movie_title|
  movie = Movie.find_by_title(movie_title)
  visit similar_directors_path(movie.id)
  assert page.has_content?(movie.director)
end
 
Then /^I should be on the home page$/ do
  visit movies_path
  assert page.has_content?('All Movies')
end
