require 'hand'
require 'rspec'
require 'card'

describe Hand do
  let(:deck) {Deck.new}
  describe 'Hand::initialize' do
    it 'initializes an empty hand' do
      expect(Hand.new(deck)).to be_is_a(Hand)
    end
    
  end
  
  
  describe 'Hand#draw_up' do
    
    it 'discards the correct cards' do
      hand = Hand.new(deck)
      hand.cards = ['a','b','c','d','e']
      hand.draw_up([1])
      expect(hand.cards).to_not be_include('b')
      #expect(hand).to_not be_include('d')
    end
    
    it 'maintains a 5 card hand' do
      hand = Hand.new(deck)
      hand.draw_up([1])
      expect(hand.cards.count).to eq(5)
    end
    
  end
  
  describe 'Hand#<=>' do

    it 'returns 1 if full house beats flush' do
      full_house = Hand.new(deck)
      full_house.cards = [Card.new(14,:spade),
                          Card.new(14,:heart),
                          Card.new(14,:diamond),
                          Card.new(2,:club),
                          Card.new(2,:diamond)]
      flush = Hand.new(deck)
      flush.cards = [Card.new(5,:spade),
                     Card.new(8,:spade),
                     Card.new(12,:spade),
                     Card.new(14,:spade),
                     Card.new(10,:spade)]
      expect(full_house <=> flush).to eq(1)
    end
    
    it "returns 1 if flush beat straight" do
      flush = Hand.new(deck)
      flush.cards = [Card.new(5,:spade),
                     Card.new(8,:spade),
                     Card.new(12,:spade),
                     Card.new(14,:spade),
                     Card.new(10,:spade)]
      straight = Hand.new(deck)
      straight.cards = [Card.new(14,:spade),
                          Card.new(13,:heart),
                          Card.new(12,:diamond),
                          Card.new(11,:club),
                          Card.new(10,:diamond)]
      expect(flush <=> straight).to eq(1)
    end
    
    it "return -1 if 3 of a kind loses to flush" do
      three_of_a_kind = Hand.new(deck)
      three_of_a_kind.cards = [Card.new(11,:spade),
                                 Card.new(8,:heart),
                                 Card.new(8,:diamond),
                                 Card.new(8,:club),
                                 Card.new(10,:spade)]
      flush = Hand.new(deck)
      flush.cards = [Card.new(5,:spade),
                       Card.new(8,:spade),
                       Card.new(12,:spade),
                       Card.new(14,:spade),
                       Card.new(10,:spade)]
      straight = Hand.new(deck)
      expect(three_of_a_kind <=> flush).to eq(-1)
    
    end
    
    it 'returns -1 if 4 of a kind loses to straight flush' do
      four_of_a_kind = Hand.new(deck)
      four_of_a_kind.cards = [Card.new(8,:spade),
                              Card.new(8,:heart),
                              Card.new(8,:diamond),
                              Card.new(8,:club),
                              Card.new(10,:spade)]
      straight_flush = Hand.new(deck)
      straight_flush.cards = [Card.new(5,:spade),
                              Card.new(6,:spade),
                              Card.new(7,:spade),
                              Card.new(8,:spade),
                              Card.new(9,:spade)]
      expect(four_of_a_kind <=> straight_flush).to eq(-1)
    end
  
    it 'returns 0 if compared to itself' do
      nothing_much = Hand.new(deck)
      nothing_much.cards = [Card.new(5,:spade),
                            Card.new(8,:heart),
                            Card.new(2,:diamond),
                            Card.new(6,:club),
                            Card.new(3,:spade)]
      expect(nothing_much <=> nothing_much).to eq(0)
    end
    
    it 'returns 1 if pair beats high card' do
      two_of_a_kind = Hand.new(deck)
      two_of_a_kind.cards = [Card.new(11,:spade),
                               Card.new(8,:heart),
                               Card.new(2,:diamond),
                               Card.new(8,:club),
                               Card.new(10,:spade)]
      high_card = Hand.new(deck)
      high_card.cards = [Card.new(14,:spade),
                         Card.new(8,:heart),
                         Card.new(2,:diamond),
                         Card.new(6,:club),
                         Card.new(10,:spade)]      
      expect(two_of_a_kind <=> high_card).to eq(1)
    end
    
    it 'returns 1 if single card beats a lower single card' do
      high_card = Hand.new(deck)
      high_card.cards = [Card.new(14,:spade),
                         Card.new(8,:heart),
                         Card.new(2,:diamond),
                         Card.new(6,:club),
                         Card.new(10,:spade)]
      nothing_much = Hand.new(deck)
      nothing_much.cards = [Card.new(5,:spade),
                            Card.new(8,:heart),
                            Card.new(2,:diamond),
                            Card.new(6,:club),
                            Card.new(3,:spade)]
      expect(high_card <=> nothing_much).to eq(1)
    end
  
    it "returns -1 if two_pair beats high card" do
      high_card = Hand.new(deck)
      high_card.cards = [Card.new(14,:spade),
                         Card.new(8,:heart),
                         Card.new(2,:diamond),
                         Card.new(6,:club),
                         Card.new(10,:spade)]
     two_of_a_kind = Hand.new(deck)
     two_of_a_kind.cards = [Card.new(11,:club),
                              Card.new(8,:heart),
                              Card.new(2,:diamond),
                              Card.new(8,:club),
                              Card.new(11,:spade)]
     expect(high_card <=> two_of_a_kind).to eq(-1)
    end
    
  end
  
  
  
end