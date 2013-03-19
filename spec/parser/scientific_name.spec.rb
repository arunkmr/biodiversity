# encoding: utf-8
#NOTE: this spec needs compiled treetop files.
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')
require File.expand_path(dir + '../../lib/biodiversity/parser')

describe ScientificNameParser do
  before(:all) do
    set_parser(ScientificNameParser.new)
  end

  it 'should return version number' do
    ScientificNameParser.version.should =~ /^\d+\.\d+\.\d+/
  end

  it 'should ScientificNameParser::fix_case' do
    names = [
      ['QUERCUS ALBA', 'Quercus alba'],
      ['QUERCUS (QUERCUS) ALBA', 'Quercus (Quercus) alba'],
      ['QÜERCUS', 'Qüercus'],
      ['PARDOSA MOéSTA', 'Pardosa moésta'],
      ['pardosa moesta', 'Pardosa moesta'],
      ['pardosa moesta', 'Pardosa moesta'],
      ['amphipappus fremontii Torr. & Gray',
        'Amphipappus fremontii Torr. & Gray'],
      ['amphipogon turbinatus R. Br.',
        'Amphipogon turbinatus R. Br.'],
      ['CArex bebbii Olney', 'Carex bebbii Olney'],
      ['CArex nigra (L.) Reichard', 'Carex nigra (L.) Reichard'],
      ['CArex nigra (L.) Reichard', 'Carex nigra (L.) Reichard'],
      ['chrysopogon aciculatus (Retz.)Trin.',
        'Chrysopogon aciculatus (Retz.)Trin.'],
      ['desmodium canadense (L.) DC.', 'Desmodium canadense (L.) DC.'],
      ['GAlium palustre L.', 'Galium palustre L.'],
      ['GLyceria striata (Lam.) A.S. Hitchc.',
        'Glyceria striata (Lam.) A.S. Hitchc.'],
      ['Peronospora leptosperma de bary', 'Peronospora leptosperma de Bary'],
      ['Gentiana piundensis van royen', 'Gentiana piundensis van Royen'],
      ['salix uva-ursi Pursh', 'Salix uva-ursi Pursh'],
      ['SolIva pterosperma (Jussieu) Less.',
        'Soliva pterosperma (Jussieu) Less.'],
      ['Spiraea alba du roi', 'Spiraea alba du Roi'],
      ['trisetum spicatum (L.) Richter s.l.',
        'Trisetum spicatum (L.) Richter s.l.'],
      ['viola blanda var. palustriformis Gray',
        'Viola blanda var. palustriformis Gray'],
      ['viridula Michx.', 'Viridula Michx.'],
      ['Acer insigne van volxemii', 'Acer insigne van Volxemii'],
      ['+ Laburnocytisus adamii (Poit.) C. Schneid.',
        'Laburnocytisus adamii (Poit.) C. Schneid.'],
    ]
    names.each do |name, capitalization|
      ScientificNameParser::fix_case(name).should == capitalization
    end
  end

  it 'should generate standardized json' do
    read_test_file do |y|
      JSON.load(json(y[:name])).should == JSON.load(y[:jsn]) unless y[:comment]
    end
  end


  # it 'should generate new test_file' do
  #   new_test = open(File.expand_path(dir +
  #                    "../../spec/parser/test_data_new.txt"),'w')
  #   read_test_file do |y|
  #     if y[:comment]
  #       new_test.write y[:comment]
  #     else
  #       name = y[:name]
  #       jsn = json(y[:name])# rescue puts(y[:name])
  #       new_test.write("#{name}|#{jsn}\n")
  #     end
  #   end
  # end

  it 'should generate reasonable output if parser failed' do
    sn = 'ddd sljlkj 3223452432'
    json(sn).should == '{"scientificName":{"parsed":false,' +
      '"parser_version":"test_version","verbatim":"ddd sljlkj 3223452432"}}'
  end

  it "should show version when the flag :show_version set to true" do
    parse('Homo sapiens')[:scientificName][:parser_version].should_not be_nil
  end

  it "should show version for not spelled names" do
    parse('not_a_name')[:scientificName][:parser_version].should_not be_nil
  end

  it "should generate version for viruses" do
    parse('Nile virus')[:scientificName][:parser_version].should_not be_nil
  end
end

describe "ScientificNameParser with ranked canonicals" do
  before(:all) do
    @parser = ScientificNameParser.new(canonical_with_rank: true)
  end

  it 'should not influence output for uninomials and binomials' do
    data = [
      ['Ekbainacanthus Yakowlew 1902','Ekbainacanthus'],
      ['Ekboarmia sagnesi herrerai Exposito 2007',
       'Ekboarmia sagnesi herrerai'],
      ['Ekboarmia holli Oberthür', 'Ekboarmia holli']]

    data.each do |d|
      parsed = @parser.parse(d[0])[:scientificName][:canonical]
      parsed.should == d[1]
    end
  end

  it 'should preserve rank for ranked multinomials' do
    data = [
      ['Cola cordifolia var. puberula A. Chev.',
       'Cola cordifolia var. puberula'],
      ['Abies homolepis forma umbilicata (Mayr) Schelle',
       'Abies homolepis forma umbilicata'],
      ['Quercus ilex ssp. ballota (Desf.) Samp',
       'Quercus ilex ssp. ballota']
    ]
    data.each do |d|
      parsed = @parser.parse(d[0])[:scientificName][:canonical]
      parsed.should == d[1]
    end
  end

end

describe ParallelParser do
  it 'should find number of cpus' do
    pparser = ParallelParser.new
    pparser.cpu_num.should > 0
  end

  it 'should parse several names in parallel' do
    names = []
    read_test_file { |n| names << (n[:name]) if n[:name] }
    names.uniq!
    pparser = ParallelParser.new
    res = pparser.parse(names)
    names.size.should > 100
    res.keys.size.should == names.size
  end

  it 'should parse several names in parallel with given num of processes' do
    names = []
    read_test_file { |n| names << (n[:name]) if n[:name] }
    names.uniq!
    pparser = ParallelParser.new(4)
    res = pparser.parse(names)
    names.size.should > 100
    res.keys.size.should == names.size
  end

  it 'should have parsed name in native ruby format and in returned as \
      a hash with name as a key and parsed data as value' do
    names = []
    read_test_file { |n| names << (n[:name]) if n[:name] }
    names.uniq!
    pparser = ParallelParser.new(4)
    res = pparser.parse(names)
    names.each_with_index do |name, i|
      res[name].is_a?(Hash).should be_true
      res[name][:scientificName][:verbatim].should == name.strip
    end
  end
end
