class GamesController < ApplicationController
  def new
    def generate_grid(grid_size)
      Array.new(grid_size) { ('A'..'Z').to_a.sample }
    end
    @letters = generate_grid(5)
  end

  def score
    if included?(attempt.upcase, grid)
      if english_word?(attempt)
        @score = "Congratulations! #{word} is a valid English word!"
      else "Sorry but #{word} does not seem to be a valid English word"
      end
    else
      "Sorry but #{word} can't be built out of"
    end
  end
end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
