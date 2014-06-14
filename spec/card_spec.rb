require 'card'
require 'rspec'

describe Card do
  
  it "implements the number setter correctly" do 
    expect(Card.instance_methods).to be_include(:number=)
  end
  
  it "implements the suit setter correctly" do 
    expect(Card.instance_methods).to be_include(:suit=)
  end
    
  let(:card) {Card.new(14, :spade)}
  it "gets its number correctly" do
    expect(card.number).to eq(14)
  end
    
end
