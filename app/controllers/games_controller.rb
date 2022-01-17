require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(9)
  end
  def score
    run_game(params[:word], params[:letters])
  end

  def chars_grid(attempt, letters)
    attempt.upcase.chars.all? { |char| letters.include?(char) && attempt.upcase.chars.count(char) <= letters.count(char) }
  end

  def run_game(attempt, letters)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    if word['found'] && chars_grid(attempt, letters)
      @result = "Congratulations! your word exists"
    elsif !word["found"]
      @result = "not an english word"
    else
      @result = "not in the grid"
    end
  end

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    grid = []
    grid_size.times do
      grid << ("A".."Z").to_a.sample(1)[0]
    end
    grid
  end
end
