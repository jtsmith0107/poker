# encoding: utf-8

require_relative 'card'

class DeckError < RuntimeError
end

class Deck
  

  
  def initialize(card_arr = nil)
    @cards = card_arr || set_cards
  end
  
  def deal_one_card
    raise DeckError.new('Deck is empty') if @cards.empty?
    @cards.pop
  end
  
  def shuffle
    @cards.shuffle!
    self
  end
  
  def empty?
    @cards.empty?
  end
  
  def count
    @cards.count
  end
  
  alias_method :length, :count
  alias_method :size, :count
  
  private
  def set_cards
    cards = []
    2.upto(14) do |number|
      Card::SUITS.keys.each do |suit|
        cards << Card.new(number, suit)
      end
    end
    cards
  end
  
end