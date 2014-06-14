class Card
  
  SUITS = {:spade => 4, :heart=> 3, :diamond => 2, :club => 1}
  
  attr_accessor :number, :suit

  def initialize(number, suit)
    @number = number
    @suit = SUITS[suit]
  end
  
  def <=>(other_card)
    num_comp = self.number <=> other_card.number
    return num_comp unless num_comp == 0
    return self.suit <=> other_card.suit
  end
    
end
