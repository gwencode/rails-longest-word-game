# rubocop:disable all
require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (1..9).map { (65 + rand(26)).chr }
  end

  def score
    letters = params[:letters]
    play = params[:play]
    play.upcase!
    grid_play = play.split('')
    grid_valid = check_grid(letters, grid_play)
    english_word = english_word(play)
    @score = 0
    # session[:score] = @score
    # @total_score = session[:score]
    if grid_valid == false
      @result = "Sorry but #{play} cant't be build out of #{letters}"
    elsif english_word["found"] == false
      @result = "Sorry but #{play} does not seem to be an english word"
    else
      @result = "Congratulations! #{play} is a valid English word!"
      @score = english_word["length"] * english_word["length"]
      # session[:score] += @score
    end
  end

  private

  def check_grid(grid, grid_play)
    validity = true
      grid_play.each do |letter|
        return validity = false if (grid.include?(letter) && grid_play.count(letter) <= grid.count(letter)) == false
      end
    return validity
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    result = JSON.parse(word_serialized)
  end

end






# "

# letters = "O J D Z Q B T N K"
# grid_play = "BONO"


# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
