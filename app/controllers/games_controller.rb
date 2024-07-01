require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @test = @word.chars.all? {|letter| @word.count(letter) <= @letters.count(letter)}
    if @test
      @result = english_word?(@word)
      if @result
        @score = "win"
      else
        @score = "lose"
      end
    else
      @score = "lose"
    end
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}",)
    json = JSON.parse(response.read)
    json["found"]
  end
end
