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
  
  
  
  

  it 'should parse names with taxon concept sec. part' do
    sn = "Sténométope laevissimus sec. Eschmeyer 2004"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Sténométope", :species=>"laevissimus", :taxon_concept=>{:authors=>{:names=>["Eschmeyer"], :year=>"2004"}}, :name_part_verbatim=>"Sténométope laevissimus", :auth_part_verbatim=>"sec. Eschmeyer 2004"}
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 29=>["author_word", 38], 39=>["year", 43]}
    sn = "Sténométope laevissimus Bibron 1855 sec. Eschmeyer 2004"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Sténométope", :species=>"laevissimus", :authors=>{:names=>["Bibron"], :year=>"1855"}, :taxon_concept=>{:authors=>{:names=>["Eschmeyer"], :year=>"2004"}}, :name_part_verbatim=>"Sténométope laevissimus", :auth_part_verbatim=>"Bibron 1855 sec. Eschmeyer 2004"}
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 24=>["author_word", 30], 31=>["year", 35], 41=>["author_word", 50], 51=>["year", 55]}
    # 
    # puts "<pre>"
    # puts @parser.failure_reason
    # #puts @parser.public_methods.select{|r| r.match /fail/}
    # puts "</pre>"
  end

  
it "should parse name with morph." do
  sn = "Callideriphus flavicollis morph. reductus Fuchs 1961"
  parse(sn).should_not be_nil
  value(sn).should == "Callideriphus flavicollis morph. reductus Fuchs 1961"
  canonical(sn).should == "Callideriphus flavicollis reductus"
  details(sn).should == {:genus=>"Callideriphus", :species=>"flavicollis", :subspecies=>[{:rank=>"morph.", :value=>"reductus"}], :authors=>{:names=>["Fuchs"], :year=>"1961"}, :name_part_verbatim=>"Callideriphus flavicollis morph. reductus", :auth_part_verbatim=>"Fuchs 1961"}
  pos(sn).should == {0=>["genus", 13], 14=>["species", 25], 33=>["subspecies", 41], 42=>["author_word", 47], 48=>["year", 52]}
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
  
  it "should parse name with forma/fo./form./f." do
    sn = "Caulerpa cupressoides forma nuda"
    parse(sn).should_not be_nil
    value(sn).should == "Caulerpa cupressoides f. nuda"
    canonical(sn).should == "Caulerpa cupressoides nuda"
    details(sn).should == {:genus=>"Caulerpa", :species=>"cupressoides", :subspecies=>[{:rank=>"f.", :value=>"nuda"}]}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 28=>["subspecies", 32]} 
    sn = "Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó"
    parse(sn).should_not be_nil
    value("Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó").should == "Chlorocyperus glaber f. fasciculariforme (Lojac.) Soó"
    canonical(sn).should == "Chlorocyperus glaber fasciculariforme"
    details(sn).should == {:genus=>"Chlorocyperus", :species=>"glaber", :subspecies=>[{:rank=>"f.", :value=>"fasciculariforme"}], :orig_authors=>{:names=>["Lojac."]}, :authors=>{:names=>["Soó"]}, :name_part_verbatim=>"Chlorocyperus glaber form. fasciculariforme", :auth_part_verbatim=>"(Lojac.) Soó"}
    pos(sn).should == {0=>["genus", 13], 14=>["species", 20], 27=>["subspecies", 43], 45=>["author_word", 51], 53=>["author_word", 56]}
    sn = "Bambusa nana Roxb. fo. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    parse(sn).should_not be_nil
    value(sn).should == "Bambusa nana Roxb. f. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    canonical(sn).should == "Bambusa nana alphonse-karri"
    details(sn).should == {:genus=>"Bambusa", :species=>"nana", :subspecies=>[{:rank=>"f.", :value=>"alphonse-karri"}], :species_authors=>{:authors=>{:names=>["Roxb."]}}, :subspecies_authors=>{:original_revised_name_authors=>{:revised_authors=>{:names=>["Mitford"]}, :authors=>{:names=>["Satow"]}}, :revised_name_authors=>{:revised_authors=>{:names=>["Makino"]}, :authors=>{:names=>["Shiros."]}}}, :name_part_verbatim=>"Bambusa nana", :auth_part_verbatim=>"Roxb. fo. alphonse-karri (Mitford ex Satow) Makino ex Shiros."}
    pos(sn).should ==  {0=>["genus", 7], 8=>["species", 12], 13=>["author_word", 18], 23=>["subspecies", 37], 39=>["author_word", 46], 50=>["author_word", 55], 57=>["author_word", 63], 67=>["author_word", 74]}
    sn = "   Sphaerotheca    fuliginea     f.    dahliae    Movss.   1967    "
    parse(sn).should_not be_nil
    value(sn).should == "Sphaerotheca fuliginea f. dahliae Movss. 1967"
    canonical(sn).should == "Sphaerotheca fuliginea dahliae"
    details(sn).should ==  {:genus=>"Sphaerotheca", :species=>"fuliginea", :subspecies=>[{:rank=>"f.", :value=>"dahliae"}], :authors=>{:names=>["Movss."], :year=>"1967"}, :name_part_verbatim=>"Sphaerotheca    fuliginea     f.    dahliae", :auth_part_verbatim=>"Movss. 1967"}
    pos(sn).should == {3=>["genus", 15], 19=>["species", 28], 39=>["subspecies", 46], 50=>["author_word", 56], 59=>["year", 63]}
  end
  
  it "should parse name with several subspecies names NOT BOTANICAL CODE BUT NOT INFREQUENT" do
    sn = "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall et D.E. Stuntz 1972"
    details(sn).should ==  {:genus=>"Hydnellum", :species=>"scrobiculatum", :subspecies=>[{:rank=>"var.", :value=>"zonatum"}, {:rank=>"f.", :value=>"parvum"}], :is_valid=>false, :orig_authors=>{:names=>["Banker"]}, :authors=>{:names=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :name_part_verbatim=>"Hydnellum scrobiculatum var. zonatum f. parvum", :auth_part_verbatim=>"(Banker) D. Hall & D.E. Stuntz 1972"}
    pos(sn).should ==  {0=>["genus", 9], 10=>["species", 23], 29=>["subspecies", 36], 40=>["subspecies", 46], 48=>["author_word", 54], 56=>["author_word", 58], 59=>["author_word", 63], 66=>["author_word", 70], 71=>["author_word", 77], 78=>["year", 82]}
  end
  
  it "should parse status BOTANICAL RARE" do
    #it is always latin abbrev often 2 words
    sn = "Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov."
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov."
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should ==  {:genus=>"Arthopyrenia", :species=>"hyalospora", :orig_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["R.C. Harris"]}, :status=>"comb. nov.", :name_part_verbatim=>"Arthopyrenia hyalospora", :auth_part_verbatim=>"(Nyl.) R.C. Harris comb. nov."}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 31=>["author_word", 35], 36=>["author_word", 42]}
  end
  
  it "should parse revised (ex) names" do
    #invalidly published
    sn = "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:genus=>"Arthopyrenia", :species=>"hyalospora", :original_revised_name_authors=>{:revised_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["Banker"]}}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"Arthopyrenia hyalospora", :auth_part_verbatim=>"(Nyl. ex Banker) R.C. Harris"}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 33=>["author_word", 39], 41=>["author_word", 45], 46=>["author_word", 52]}
    
    parse("Arthopyrenia hyalospora Nyl. ex Banker").should_not be_nil
    sn = "Glomopsis lonicerae Peck ex C.J. Gould 1945"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Glomopsis", :species=>"lonicerae", :revised_name_authors=>{:revised_authors=>{:names=>["Peck"]}, :authors=>{:names=>["C.J. Gould"], :year=>"1945"}}, :name_part_verbatim=>"Glomopsis lonicerae", :auth_part_verbatim=>"Peck ex C.J. Gould 1945"}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 20=>["author_word", 24], 28=>["author_word", 32], 33=>["author_word", 38], 39=>["year", 43]}
    parse("Acanthobasidium delicatum (Wakef.) Oberw. ex Jülich 1979").should_not be_nil
    sn = "Mycosphaerella eryngii (Fr. ex Duby) Johanson ex Oudem. 1897"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Mycosphaerella", :species=>"eryngii", :original_revised_name_authors=>{:revised_authors=>{:names=>["Fr."]}, :authors=>{:names=>["Duby"]}}, :revised_name_authors=>{:revised_authors=>{:names=>["Johanson"]}, :authors=>{:names=>["Oudem."], :year=>"1897"}}, :name_part_verbatim=>"Mycosphaerella eryngii", :auth_part_verbatim=>"(Fr. ex Duby) Johanson ex Oudem. 1897"}
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22], 24=>["author_word", 27], 31=>["author_word", 35], 37=>["author_word", 45], 49=>["author_word", 55], 56=>["year", 60]}
    #invalid but happens
    parse("Mycosphaerella eryngii (Fr. Duby) ex Oudem. 1897").should_not be_nil
    parse("Mycosphaerella eryngii (Fr.ex Duby) ex Oudem. 1897").should_not be_nil
    sn = "Salmonella werahensis (Castellani) Hauduroy and Ehringer in Hauduroy 1937"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 10], 11=>["species", 21], 23=>["author_word", 33], 35=>["author_word", 43], 48=>["author_word", 56], 60=>["author_word", 68], 69=>["year", 73]}
  end
  
  it "should parse multiplication sign" do
    sn = "Arthopyrenia x hyalospora (Nyl.) R.C. Harris"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Arthopyrenia", :species=>"hyalospora", :cross=>"inside", :orig_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"Arthopyrenia x hyalospora", :auth_part_verbatim=>"(Nyl.) R.C. Harris"}
    pos(sn).should == {0=>["genus", 12], 15=>["species", 25], 27=>["author_word", 31], 33=>["author_word", 37], 38=>["author_word", 44]}
    parse("Arthopyrenia X hyalospora(Nyl. ex Banker) R.C. Harris").should_not be_nil
    sn = "x Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    details(sn).should ==  {:genus=>"Arthopyrenia", :species=>"hyalospora", :cross=>"before", :original_revised_name_authors=>{:revised_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["Banker"]}}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"x Arthopyrenia hyalospora", :auth_part_verbatim=>"(Nyl. ex Banker) R.C. Harris"}
    pos(sn).should == {2=>["genus", 14], 15=>["species", 25], 27=>["author_word", 31], 35=>["author_word", 41], 43=>["author_word", 47], 48=>["author_word", 54]}
    sn = "X Arthopyrenia (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    details(sn).should == {:uninomial=>"Arthopyrenia", :cross=>"before", :original_revised_name_authors=>{:revised_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["Banker"]}}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"X Arthopyrenia", :auth_part_verbatim=>"(Nyl. ex Banker) R.C. Harris"}
    pos(sn).should == {2=>["uninomial", 14], 16=>["author_word", 20], 24=>["author_word", 30], 32=>["author_word", 36], 37=>["author_word", 43]}
    #ascii for multiplication
    parse("Melampsora × columbiana G. Newc. 2000").should_not be_nil
  end
  
  it "should parse hybrid combination" do
    sn = "Arthopyrenia hyalospora X Hydnellum scrobiculatum"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    canonical(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    details(sn).should == {:hybrid=>{:scientific_name1=>{:species=>"hyalospora", :genus=>"Arthopyrenia"}, :scientific_name2=>{:species=>"scrobiculatum", :genus=>"Hydnellum"}}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 26=>["genus", 35], 36=>["species", 49]}
    sn = "Arthopyrenia hyalospora (Banker) D. Hall X Hydnellum scrobiculatum D.E. Stuntz"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Banker) D. Hall \303\227 Hydnellum scrobiculatum D.E. Stuntz"
    canonical(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 31], 33=>["author_word", 35], 36=>["author_word", 40], 43=>["genus", 52], 53=>["species", 66], 67=>["author_word", 71], 72=>["author_word", 78]}
    value("Arthopyrenia hyalospora X").should == "Arthopyrenia hyalospora \303\227 ?"  
    sn = "Arthopyrenia hyalospora x"
    parse(sn).should_not be_nil
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:hybrid=>{:scientific_name1=>{:species=>"hyalospora", :genus=>"Arthopyrenia"}, :scientific_name2=>"?"}}  
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
    sn = "Arthopyrenia hyalospora × ?"
    parse(sn).should_not be_nil
    details(sn).should == {:hybrid=>{:scientific_name1=>{:species=>"hyalospora", :genus=>"Arthopyrenia"}, :scientific_name2=>"?"}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
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
