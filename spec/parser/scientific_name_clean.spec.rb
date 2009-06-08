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
  
  it 'should parse canonical' do
    sn = 'Pseudocercospora     dendrobii'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora dendrobii'
    canonical(sn).should == 'Pseudocercospora dendrobii'
    details(sn).should == {:species=>"dendrobii", :genus=>"Pseudocercospora"}
    pos(sn).should == {0=>["genus", 16], 21=>["species", 30]}
  end
end