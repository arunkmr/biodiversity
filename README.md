Biodiversity
============

[![Gem Version][1]][2]
[![Continuous Integration Status][3]][4]
[![CodePolice][5]][6]
[![Dependency Status][7]][8]

Parses taxonomic scientific name and breaks it into semantic elements.

Installation
------------

*WARNING:* Do not use Ruby 1.8.7 -- it is outdated. The
biodiversity gem for Ruby 1.8.7 is not getting updated anymore

    sudo gem install biodiversity #for ruby 1.8.x
    sudo gem install biodiversity19 #for ruby 1.9.x

Example usage
-------------

### As a command line script

You can parse file with taxonomic names from command line. 
File should contain one scientific name per line

    nnparser file_with_names

### As a socket server

If you do not use Ruby and need a fast access to the parser functionality  
you can use a socket server

    parserver

    parserver -h
    Usage: ruby parserver [options]

        -r, --canonical_with_rank        Adds infraspecies rank to canonical forms

        -o, --output=output              Specifies the type of the output:
        json - parsed results in json
        canonical - canonical form only
                                         Default: json

        -p, --port=port                  Specifies the port number
                                         Default: 4334

        -h, --help                       Show this help message.

    parserver --output=canonical



With default settings you can access parserserver via 4334 port using a 
socket client library of your programming language.  You can find 
[socket client script example][9] in the examples directory of the gem.

If you want to check if socket server works for you:

    #run server in one terminal
    parserver

    #in another terminal window type
    telnet localhost 4334

If you enter a line with a scientific name -- server will send you back 
parsed information in json format.

To stop telnet client type any of `end`,`exit`,`q`, `.` instead 
of scientific name

    $ telnet localhost 4334
    Trying ::1...
    Connected to localhost.
    Escape character is '^]'.
    Acacia abyssinica Hochst. ex Benth. ssp. calophylla Brenan
    {"scientificName":{"canonical":"Acacia abyssinica calophylla"...}}
    end

### As a library

    You can use it as a library
    
    require 'biodiversity'
    
    parser = ScientificNameParser.new
    
    # to fix capitalization in canonicals
    ScientificNameParser.fix_case("QUERCUS (QUERCUS) ALBA") # Quercus (Quercus) alba
    
    # to parse a scientific name into a ruby hash
    parser.parse("Plantago major")
    
    #to get json representation
    parser.parse("Plantago").to_json
    #or
    parser.parse("Plantago")
    parser.all_json
    
    # to clean name up
    parser.parse("             Plantago       major    ")[:scientificName][:normalized]
    
    # to get only cleaned up latin part of the name
    parser.parse("Pseudocercospora dendrobii (H.C. Burnett) U. Braun & Crous 2003")[:scientificName][:canonical]
    
    # to get detailed information about elements of the name
    parser.parse("Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun & Crous 2003")[:scientificName][:details]
    
    # to parse using several CPUs (4 seem to be optimal)
    parser = ParallelParser.new # ParallelParser.new(4) will try to run 4 processes if hardware allows
    array_of_names = ["Betula alba", "Homo sapiens"....]
    parser.parse(array_of_names) # -> {"Betula alba" => {:scientificName...}, "Homo sapiens" => {:scientificName...}, ...}


To parse using several CPUs (4 seem to be optimal)

    parser = ParallelParser.new # ParallelParser.new(4) will try to run 4 processes if hardware allows
    array_of_names = ["Betula alba", "Homo sapiens"....]
    parser.parse(array_of_names) # -> {"Betula alba" => {:scientificName...}, "Homo sapiens" => {:scientificName...}, ...}

parallel parser takes list of names and returns back a hash with names as keys and parsed data as values

To get canonicals with ranks for infraspecific epithets:

    parser = ScientificNameParser.new(canonical_with_rank: true)
    parser.parse('Cola cordifolia var. puberula A. Chev.')[:scientificName][:canonical]
    # should get 'Cola cordifolia var. puberula'

To resolve lsid and get back RDF file

    LsidResolver.resolve("urn:lsid:ubio.org:classificationbank:2232671")



[1]: https://badge.fury.io/rb/biodiversity19.png
[2]: http://badge.fury.io/rb/biodiversity19
[3]: https://secure.travis-ci.org/GlobalNamesArchitecture/biodiversity.png
[4]: http://travis-ci.org/GlobalNamesArchitecture/biodiversity
[5]: https://codeclimate.com/github/GlobalNamesArchitecture/biodiversity.png
[6]: https://codeclimate.com/github/GlobalNamesArchitecture/biodiversity
[7]: https://gemnasium.com/GlobalNamesArchitecture/biodiversity.png
[8]: https://gemnasium.com/GlobalNamesArchitecture/biodiversity
[9]: https://github.com/GlobalNamesArchitecture/biodiversity/blob/master/examples/socket_client.rb