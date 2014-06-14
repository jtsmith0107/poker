require_relative 'card'
require_relative 'deck'

class Hand
  
  attr_accessor :cards
  
  def initialize(deck)
    @cards = Array.new(5)
    @deck = deck
  end
  
  def draw_up(discard_indices)
    # pop cards @ discard indices
    discard_indices.each do |idx| 
      @cards[idx] = nil
    end
    @cards.each_with_index do |card, i|
      @cards[i] = @deck.deal_one_card if card.nil?
    end
    self
  end  
  
  def <=>(other_hand)
    self.score <=> other_hand.score
  end
  
  
  
  def score
    str_score = straight
    flu_score = flush
    return [8, high_card] if straight && flush
    mul_score = multiples
    return mul_score if mul_score.first == 7 # four of a kind
    return mul_score if mul_score.first == 6 # full house
    return flush if flush
    return str_score if straight
    return mul_score
  end
  
  private
  
  def straight
    cards = @cards.map do |card|
      card.number
    end
    cards.sort.each_with_index do |card, idx|
      next if idx == 0
      return false if card - cards[idx-1] != 1
    end
    [4, high_card]
  end
  
  def flush
    card_suits = @cards.map do |card| 
      card.suit
    end
    return [5, high_card] if card_suits.uniq.count == 1
    false
  end
    
  def multiples
    card_count = @cards.inject(Hash.new{|h,k| h[k] = []}) do |card_count, card|
      card_count[card.number] << card
      card_count
    end

    
    # card_count is an array from numbers to arrays of cards

    multiples = []
    card_count.values.each do |value| 
      if value.count > 1
        multiples << value 
      end
    end

    fours = multiples.find {|card_set| card_set.count == 4}
    if !fours.nil?
      return [7,fours.max] # four of a kind
    end
    threes = multiples.find {|card_set| card_set.count == 3}

    twos = multiples.select {|card_set| card_set.count == 2}.flatten
    # p twos
    if !threes.nil? && !twos.empty?
      return [6, threes.max] # full house
    end
    if !threes.nil?
      return [3, threes.max] # three of a kind
    end
    if twos.count == 4
      return [2, twos.max] # two pair
    end
    if !twos.empty?
      return [1, twos.max] # pair
    end
    [0,high_card] # high card
  end
  
  def high_card
    @cards.max
  end
  
  
end