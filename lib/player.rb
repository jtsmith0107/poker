class Player
  def initialize(name, money)
    @hand = Hand.new
    @name = name
    @money = money
  end
  
  def see_bet
    
  end
  
  def raise_bet(amount)
    
  end
  
  def draw(num_cards)
    
  end
  
  def broke?
    @money > 0
  end

end