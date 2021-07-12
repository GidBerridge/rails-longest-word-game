require 'open-uri'

class GamesController < ApplicationController

  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
  end


  def score
    @letters = params[:letters].split
    @attempt = (params[:answer] || "").upcase
    @included = included?(@attempt, @letters)
    @english_word = english_word?(@attempt)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}")
    json = JSON.parse(url.read)
    json['found']
  end
end
