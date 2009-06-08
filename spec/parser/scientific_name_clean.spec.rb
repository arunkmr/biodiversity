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
    # puts "<pre>"
    # puts @parser.to_yaml
    # puts "</pre>"
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
  
  
end