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
    cards_numbers = @cards.map { |card| card.number }
    cards_numbers.sort.each_with_index do |card, idx|
      next if idx == 0
      return false unless card - cards_numbers[idx-1] == 1
    end
    [4, high_card]
  end
  
  def flush
    card_suits = @cards.map { |card| card.suit }
    return [5, high_card] if card_suits.uniq.count == 1
    false
  end
    
  def multiples
    # card_count is an array from numbers to arrays of cards
    card_count = Hash.new { |h, k| h[k] = [] }
    @cards.each { |card| card_count[card.number] << card }

    multiples = []
    card_count.values.each { |value|  multiples << value if value.count > 1 }

    fours = multiples.find { |card_set| card_set.count == 4 }
    return [7,fours.max] if !fours.nil?                    # four of a kind

    threes = multiples.find { |card_set| card_set.count == 3 }
    twos = multiples.select { |card_set| card_set.count == 2 }.flatten
    return [6, threes.max] if !threes.nil? && !twos.empty? # full house
    return [3, threes.max] if !threes.nil?                 # three of a kind
    return [2, twos.max] if twos.count == 4                # two pair
    return [1, twos.max] if !twos.empty?                   # pair

    [0,high_card]                                          # high card
  end
  
  def high_card
    @cards.max
  end
  
  
end