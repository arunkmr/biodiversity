# encoding: UTF-8
dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'yaml'
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
  
  it 'should parse uninomial' do
    sn = 'Pseudocercospora'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora'
    canonical(sn).should == 'Pseudocercospora'
    details(sn).should == {:uninomial=>{:epitheton=>"Pseudocercospora"}}
    pos(sn).should == {0=>["uninomial", 16]}
  end
  
  it 'should parse uninomial with author and year' do
    sn = 'Pseudocercospora Speg.'
    parse(sn).should_not be_nil
    details(sn).should == {:uninomial=>{:epitheton=>"Pseudocercospora", :authorship=>"Speg.", :basionymAuthorTeam=>{:authorTeam=>"Speg.", :author=>["Speg."]}}}
    pos(sn).should == {0=>["uninomial", 16], 17=>["author_word", 22]}    
    sn = 'Pseudocercospora Spegazzini, 1910'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora Spegazzini 1910'
    details(sn).should == {:uninomial=>{:epitheton=>"Pseudocercospora", :authorship=>"Spegazzini, 1910", :basionymAuthorTeam=>{:authorTeam=>"Spegazzini", :author=>["Spegazzini"], :year=>"1910"}}}
    pos(sn).should == {0=>["uninomial", 16], 17=>["author_word", 27], 29=>["year", 33]}
  end
  
  it 'should parse names with a valid 2 letter genus' do
    ["Ca Dyar 1914",
    "Ea Distant 1911",
    "Ge Nicéville 1895",
    "Ia Thomas 1902",
    "Io Lea 1831",
    "Io Blanchard 1852",
    "Ix Bergroth 1916",
    "Lo Seale 1906",
    "Oa Girault 1929",
    "Ra Whitley 1931",
    "Ty Bory de St. Vincent 1827",
    "Ua Girault 1929",
    "Aa Baker 1940",
    "Ja Uéno 1955",
    "Zu Walters & Fitch 1960",
    "La Bleszynski 1966",
    "Qu Durkoop",
    "As Slipinski 1982",
    "Ba Solem 1983"].each do |name|
      parse(name).should_not be_nil
    end
    canonical('Quoyula').should == 'Quoyula'
  end
  
  it 'should parse canonical' do
    sn = 'Pseudocercospora     dendrobii'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora dendrobii'
    canonical(sn).should == 'Pseudocercospora dendrobii'
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii"}}
    pos(sn).should == {0=>["genus", 16], 21=>["species", 30]}
  end
  
  
  it 'should parse species name with author and year' do
    sn = "Platypus bicaudatulus Schedl 1935"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    sn = "Platypus bicaudatulus Schedl, 1935h"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    details(sn).should == {:genus=>{:epitheton=>"Platypus"}, :species=>{:epitheton=>"bicaudatulus", :authorship=>"Schedl, 1935h", :basionymAuthorTeam=>{:authorTeam=>"Schedl", :author=>["Schedl"], :year=>"1935"}}}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 22=>["author_word", 28], 30=>["year", 35]}
    parse("Platypus bicaudatulus Schedl, 1935B").should_not be_nil
  end
  
  it 'should parse genus with "?"' do
    sn = "Ferganoconcha? oblonga"
    parse(sn).should_not be_nil
    value(sn).should == "Ferganoconcha oblonga"
    details(sn).should == {:genus=>{:epitheton=>"Ferganoconcha"}, :species=>{:epitheton=>"oblonga"}}
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22]}
  end
  
  it 'should parse æ in the name' do
    names = [
      ["Læptura laetifica Dow, 1913", "Laeptura laetifica Dow 1913"],
      ["Leptura lætifica Dow, 1913", "Leptura laetifica Dow 1913"],
      ["Leptura leætifica Dow, 1913", "Leptura leaetifica Dow 1913"],
      ["Leæptura laetifica Dow, 1913", "Leaeptura laetifica Dow 1913"],
      ["Leœptura laetifica Dow, 1913", "Leoeptura laetifica Dow 1913"],
      ['Ærenea cognata Lacordaire, 1872', 'Aerenea cognata Lacordaire 1872'],
      ['Œdicnemus capensis', 'Oedicnemus capensis'],
      ['Œnanthe œnanthe','Oenanthe oenanthe']
    ]
    names.each do |name_pair|
      parse(name_pair[0]).should_not be_nil
      value(name_pair[0]).should == name_pair[1]
    end
  end
  
  it 'should parse names with "common" utf-8 charactes' do
    names = ["Rühlella","Sténométope laevissimus Bibron 1855"].each do |name|
      parse(name).should_not be_nil
    end
    sn = "Trematosphaeria phaeospora (E. Müll.)         L.             Holm 1957"
    parse(sn).should_not be_nil
    value(sn).should == "Trematosphaeria phaeospora (E. Müll.) L. Holm 1957"
    canonical(sn).should == "Trematosphaeria phaeospora"
    details(sn).should == {:genus=>{:epitheton=>"Trematosphaeria"}, :species=>{:epitheton=>"phaeospora", :authorship=>"(E. Müll.)         L.             Holm 1957", :combinationAuthorTeam=>{:authorTeam=>"L.             Holm", :author=>["L. Holm"], :year=>"1957"}, :basionymAuthorTeam=>{:authorTeam=>"E. Müll.", :author=>["E. Müll."]}}}
    pos(sn).should == {0=>["genus", 15], 16=>["species", 26], 28=>["author_word", 30], 31=>["author_word", 36], 46=>["author_word", 48], 61=>["author_word", 65], 66=>["year", 70]}
    
  end
    
  it 'should parse subgenus (ICZN code)' do
    sn = "Hegeter (Hegeter) intercedens Lindberg H 1950"
    parse(sn).should_not be_nil
    value(sn).should == "Hegeter (Hegeter) intercedens Lindberg H 1950"
    canonical(sn).should == "Hegeter intercedens"
    details(sn).should == {:genus=>{:epitheton=>"Hegeter"}, :subgenus=>{:epitheton=>"Hegeter"}, :species=>{:epitheton=>"intercedens", :authorship=>"Lindberg H 1950", :basionymAuthorTeam=>{:authorTeam=>"Lindberg H", :author=>["Lindberg H"], :year=>"1950"}}}
    pos(sn).should == {0=>["genus", 7], 9=>["subgenus", 16], 18=>["species", 29], 30=>["author_word", 38], 39=>["author_word", 40], 41=>["year", 45]}
  end
  
  it 'should parse several authors without a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should ==  {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"U. Braun & Crous", :basionymAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"]}}}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43]}
    sn = "Pseudocercospora dendrobii U. Braun and Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 40=>["author_word", 45]}
    sn = "Pseudocercospora dendrobii U. Braun et Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"    
    sn = "Arthopyrenia hyalospora(Nyl.)R.C.     Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl.) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora", :authorship=>"(Nyl.)R.C.     Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C.     Harris"}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."]}}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 24=>["author_word", 28], 29=>["author_word", 33], 38=>["author_word", 44]}
  end
  
  

  it 'should parse several authors with a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"U. Braun & Crous 2003", :basionymAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}}}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43], 44=>["year", 48]}
    sn = "Pseudocercospora dendrobii Crous, 2003"
    parse(sn).should_not be_nil
  end
  
  it 'should parse basionym authors in parenthesis' do
    sn = "Zophosis persis (Chatanay, 1914)"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Zophosis"}, :species=>{:epitheton=>"persis", :authorship=>"(Chatanay, 1914)", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}
    sn = "Zophosis persis (Chatanay 1914)"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Zophosis"}, :species=>{:epitheton=>"persis", :authorship=>"(Chatanay 1914)", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}
    sn = "Zophosis persis (Chatanay), 1914"
    parse(sn).should_not be_nil
    value(sn).should == "Zophosis persis (Chatanay 1914)"
    details(sn).should == {:genus=>{:epitheton=>"Zophosis"}, :species=>{:epitheton=>"persis", :authorship=>"(Chatanay), 1914", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 15], 17=>["author_word", 25], 28=>["year", 32]}
    parse("Zophosis persis (Chatanay) 1914").should_not be_nil
    #parse("Zophosis persis Chatanay (1914)").should_not be_nil
  end  
  
  it 'should parse scientific name' do
    sn = "Pseudocercospora dendrobii(H.C.     Burnett)U. Braun & Crous     2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"(H.C.     Burnett)U. Braun & Crous     2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C.     Burnett", :author=>["H.C. Burnett"]}}}
    sn = "Pseudocercospora dendrobii(H.C.     Burnett,1873)U. Braun & Crous     2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1873) U. Braun et Crous 2003"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"(H.C.     Burnett,1873)U. Braun & Crous     2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C.     Burnett", :author=>["H.C. Burnett"], :year=>"1873"}}}
  end
  
  it 'should parse several authors with several years' do
    sn = "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"(H.C. Burnett 1883) U. Braun & Crous 2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C. Burnett", :author=>["H.C. Burnett"], :year=>"1883"}}}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 28=>["author_word", 32], 33=>["author_word", 40], 41=>["year", 45], 47=>["author_word", 49], 50=>["author_word", 55], 58=>["author_word", 63], 64=>["year", 68]}
  end

  it "should parse name with subspecies without rank Zoological Code" do
    sn = "Hydnellum scrobiculatum zonatum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum zonatum (Banker) D. Hall et D.E. Stuntz 1972"
    canonical(sn).should == "Hydnellum scrobiculatum zonatum"
    details(sn).should == {:genus=>{:epitheton=>"Hydnellum"}, :species=>{:epitheton=>"scrobiculatum"}, :infraspecies=>{:epitheton=>"zonatum", :rank=>"n/a", :authorship=>"(Banker) D. Hall & D.E. Stuntz 1972", :combinationAuthorTeam=>{:authorTeam=>"D. Hall & D.E. Stuntz", :author=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :basionymAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 23], 24=>[{"subspecies"=>31}], 33=>["author_word", 39], 41=>["author_word", 43], 44=>["author_word", 48], 51=>["author_word", 55], 56=>["author_word", 62], 63=>["year", 67]}
    sn = "Begonia pingbienensis angustior"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Begonia", :species=>"pingbienensis", :subspecies=>{:rank=>"n/a", :value=>"angustior"}}
    pos(sn).should == {0=>["genus", 7], 8=>["species", 21], 22=>[{"subspecies"=>31}]}
  end



  it 'should parse unknown original authors (auct.)/(hort.)/(?)' do
    sn = "Tragacantha leporina (?) Kuntze"
    parse(sn).should_not be_nil
    value(sn).should == "Tragacantha leporina (?) Kuntze"
    details(sn).should == {:genus=>{:epitheton=>"Tragacantha"}, :species=>{:epitheton=>"leporina", :authorship=>"(?) Kuntze", :combinationAuthorTeam=>{:authorTeam=>"Kuntze"}, :basionymAuthorTeam=>{:authorTeam=>"(?)", :author=>["?"]}}}
    # sn = "Lachenalia tricolor var. nelsonii (auct.) Baker"
    # parse(sn).should_not be_nil
    # value(sn).should == "Lachenalia tricolor var. nelsonii (auct.) Baker"
    # details(sn).should == {:genus=>"Lachenalia", :species=>"tricolor", :subspecies=>[{:rank=>"var.", :value=>"nelsonii"}], :orig_authors=>"unknown", :authors=>{:names=>["Baker"]}, :name_part_verbatim=>"Lachenalia tricolor var. nelsonii", :auth_part_verbatim=>"(auct.) Baker"}
    # pos(sn).should == {0=>["genus", 10], 11=>["species", 19], 25=>["subspecies", 33], 35=>["unknown_author", 40], 42=>["author_word", 47]}
  end  
  
  it 'should parse unknown authors auct./anon./hort./ht.' do
    sn = "Puya acris ht."
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 4], 5=>["species", 10], 11=>["unknown_author", 14]}
  end
  
   
    
  it 'should not parse serveral authors groups with several years NOT CORRECT' do
    parse("Pseudocercospora dendrobii (H.C. Burnett 1883) (Leight.) (Movss. 1967) U. Braun & Crous 2003").should be_nil
  end

  it "should not parse unallowed utf-8 chars in name part" do
    parse("Érematosphaeria phaespora").should be_nil
    parse("Trematosphaeria phaeáapora").should be_nil
    parse("Trematоsphaeria phaeáapora").should be_nil #cyrillic o
  end

  
end