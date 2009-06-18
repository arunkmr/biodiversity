# encoding: UTF-8
dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'treetop'

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_clean'))

describe ScientificNameClean do
  before(:all) do
    @parser = ScientificNameCleanParser.new 
  end
  
  def parse(input)
    @parser.parse(input)
  end
  
  def value(input)
    parse(input).value
  end
  
  def canonical(input)
    parse(input).canonical
  end
  
  def details(input)
    parse(input).details
  end
  
  def pos(input)
    parse(input).pos
  end
  
  
  
  

 

#  "subsect."/"subtrib."/"subgen."/"trib."/
#Stipa Speg. subgen. Leptostipa
#Sporobolus subgen. Sporobolus R.Br.

# it 'should parse name with "subsect."/"subtrib."/"subgen."/"trib."' do
#   val = "Sporobolus subgen. Sporobolus R.Br."
#   parse(val).should_not be_nil
#   # value(val).should == val
#   # canonical(val).should == "Callideriphus flavicollis reductus"
#   # details(val).should == {}
# end

  
  it "should parse name with several subspecies names NOT BOTANICAL CODE BUT NOT INFREQUENT" do
    sn = "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall et D.E. Stuntz 1972"
    details(sn).should ==  {:genus=>"Hydnellum", :species=>"scrobiculatum", :subspecies=>[{:rank=>"var.", :value=>"zonatum"}, {:rank=>"f.", :value=>"parvum"}], :is_valid=>false, :orig_authors=>{:names=>["Banker"]}, :authors=>{:names=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :name_part_verbatim=>"Hydnellum scrobiculatum var. zonatum f. parvum", :auth_part_verbatim=>"(Banker) D. Hall & D.E. Stuntz 1972"}
    pos(sn).should ==  {0=>["genus", 9], 10=>["species", 23], 29=>["subspecies", 36], 40=>["subspecies", 46], 48=>["author_word", 54], 56=>["author_word", 58], 59=>["author_word", 63], 66=>["author_word", 70], 71=>["author_word", 77], 78=>["year", 82]}
  end
  
  it "should parse some invalid names" do
    parse("Acarospora cratericola 1929").should_not be_nil
    parse("Agaricus acris var. (b.)").should_not be_nil  
    value("Agaricus acris var. (b.)").should == "Agaricus acris var. (b.)"  
    parse("Agaricus acris var. (b.)").should_not be_nil 
    sn = "Agaricus acris var. (b.&c.)"
    value(sn).should == "Agaricus acris var. (b.c.)"  
    details(sn).should == {:editorial_markup=>"(b.c.)", :subspecies=>[{:rank=>"var.", :value=>nil}], :species=>"acris", :genus=>"Agaricus", :is_valid=>false}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 14]}
  end

  it 'should parse double parenthesis' do
    sn = "Eichornia crassipes ( (Martius) ) Solms-Laub."
    parse(sn).should_not be_nil
    value(sn).should == "Eichornia crassipes (Martius) Solms-Laub."
    details(sn).should == {:genus=>"Eichornia", :species=>"crassipes", :orig_authors=>{:names=>["Martius"]}, :authors=>{:names=>["Solms-Laub."]}, :name_part_verbatim=>"Eichornia crassipes", :auth_part_verbatim=>"( (Martius) ) Solms-Laub."}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 23=>["author_word", 30], 34=>["author_word", 45]} 
  end

#  val = "Ferganoconcha? oblonga"
  
end
