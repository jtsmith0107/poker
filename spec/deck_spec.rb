require 'deck'
require 'rspec'

describe Deck do

  describe 'Deck::initialize' do

    it 'initializes a deck with an array argument' do
      expect(Deck.new([1,2,3])).to_not raise_error(ArgumentError)
    end
        
  end
  
  describe 'Deck#count' do
    
   it 'should return the correct number' do
     deck = Deck.new([1,2,3])
     expect(deck.count).to eq(3)
   end
   
   it 'should return 0 for an empty deck' do
     deck = Deck.new([])
     expect(deck.count).to eq(0)
   end
   
  end
  
  describe 'Deck::initialize' do
    
    it 'initializes a deck with 52 cards by default' do
      expect(subject.count).to eq(52)
    end
    
  end
  
  describe 'Deck#deal_one_card' do
    
    it 'deals a card' do
      expect(subject.deal_one_card).to be_is_a(Card)
    end
    
    it 'removes one card from deck' do
      deck = Deck.new
      size = deck.count
      deck.deal_one_card
      expect(deck.count).to eq(size-1)
    end
    
    it 'raises an error if deck is empty' do
      deck = Deck.new
      expect{ 53.times {deck.deal_one_card}}.to raise_error(DeckError)
    end
    
  end
  
  describe 'Deck#shuffle' do
    
    it 'shuffles a deck' do
      deck = Deck.new([1,2,3,4,5,6,7])
      deck.shuffle
      arr = []
      3.times {arr << deck.deal_one_card}
      expect(arr).to_not eq([1,2,3])
    end
  
  end
  
  describe 'Deck#empty?' do
    
    it 'returns false if there are cards left' do
      deck = Deck.new([1,2,3])
      expect(deck.empty?).to eq(false)
    end
    
    it 'returns true if there are no cards left' do
      deck = Deck.new([])
      expect(deck.empty?).to eq(true)
    end
    
  end
  
end