# encoding: UTF-8
module ScientificNameClean
  include Treetop::Runtime

  def root
    @root || :scientific_name
  end

  def _nt_scientific_name
    start_index = index
    if node_cache[:scientific_name].has_key?(index)
      cached = node_cache[:scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_species_name
    if r1
      r0 = r1
    else
      r2 = _nt_uninomial_name
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:scientific_name][start_index] = r0

    return r0
  end

  module SpeciesName0
    def a
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module SpeciesName1
    def value
      a.value + " " + b.value 
    end

    def canonical
      value
    end
    
    def pos
      {a.interval.begin => ['genus', a.interval.end], b.interval.begin => ['species', b.interval.end]}
    end
    
    def details
      {:genus => {:epitheton => a.value}, :species => {:epitheton => b.value}}
    end
  end

  def _nt_species_name
    start_index = index
    if node_cache[:species_name].has_key?(index)
      cached = node_cache[:species_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_cap_latin_word
    s0 << r1
    if r1
      r2 = _nt_space_hard
      s0 << r2
      if r2
        r3 = _nt_latin_word
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(SpeciesName0)
      r0.extend(SpeciesName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:species_name][start_index] = r0

    return r0
  end

  module UninomialName0
    def a
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module UninomialName1
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      {:uninomial => a.details[:uninomial].merge(b.details)}
    end
  end

  def _nt_uninomial_name
    start_index = index
    if node_cache[:uninomial_name].has_key?(index)
      cached = node_cache[:uninomial_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_uninomial_epitheton
    s1 << r2
    if r2
      r3 = _nt_space_hard
      s1 << r3
      if r3
        r4 = _nt_authorship
        s1 << r4
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(UninomialName0)
      r1.extend(UninomialName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_uninomial_epitheton
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:uninomial_name][start_index] = r0

    return r0
  end

  module UninomialEpitheton0
    def canonical
      value
    end
    
    def pos
      {interval.begin => ['uninomial', interval.end]}
    end
    
    def details 
      {:uninomial => {:epitheton => value}}
    end
  end

  def _nt_uninomial_epitheton
    start_index = index
    if node_cache[:uninomial_epitheton].has_key?(index)
      cached = node_cache[:uninomial_epitheton][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_cap_latin_word
    r0.extend(UninomialEpitheton0)

    node_cache[:uninomial_epitheton][start_index] = r0

    return r0
  end

  module Authorship0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module Authorship1
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      { :authorship => text_value, 
        :basionymAuthorTeam => {
          :authorTeam => a.text_value
        }.merge(a.details).merge(b.details)
      }
    end
  end

  module Authorship2
    def details
      { :authorship => text_value, 
        :basionymAuthorTeam => {
          :authorTeam => text_value
        }.merge(super)
      }      
    end
  end

  def _nt_authorship
    start_index = index
    if node_cache[:authorship].has_key?(index)
      cached = node_cache[:authorship][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_authors_names
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if input.index(Regexp.new('[,]'), index) == index
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r5 = nil
        end
        if r5
          r4 = r5
        else
          r4 = instantiate_node(SyntaxNode,input, index...index)
        end
        s1 << r4
        if r4
          r6 = _nt_space
          s1 << r6
          if r6
            r7 = _nt_year
            s1 << r7
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Authorship0)
      r1.extend(Authorship1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r8 = _nt_authors_names
      r8.extend(Authorship2)
      if r8
        r0 = r8
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authorship][start_index] = r0

    return r0
  end

  module AuthorsNames0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def sep
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module AuthorsNames1
    def value
      sep.apply(a,b)
    end
    
    def pos
      sep.pos(a,b)
    end
    
    def details
      sep.details(a,b)
    end
  end

  def _nt_authors_names
    start_index = index
    if node_cache[:authors_names].has_key?(index)
      cached = node_cache[:authors_names][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_author_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_author_separator
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_authors_names
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(AuthorsNames0)
      r1.extend(AuthorsNames1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_author_name
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors_names][start_index] = r0

    return r0
  end

  module AuthorSeparator0
    def apply(a,b)
      sep = text_value.strip
      sep = " et" if ["&","and","et"].include? sep
      a.value + sep + " " + b.value
    end
    
    def pos(a,b)
      a.pos.merge(b.pos)
    end
    
    def details(a,b)
      {:author => a.details[:author] + b.details[:author]}
    end
  end

  def _nt_author_separator
    start_index = index
    if node_cache[:author_separator].has_key?(index)
      cached = node_cache[:author_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("&", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("&")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(AuthorSeparator0)
    else
      if input.index(",", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(",")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(AuthorSeparator0)
      else
        if input.index("and", index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 3))
          @index += 3
        else
          terminal_parse_failure("and")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(AuthorSeparator0)
        else
          if input.index("et", index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("et")
            r4 = nil
          end
          if r4
            r0 = r4
            r0.extend(AuthorSeparator0)
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:author_separator][start_index] = r0

    return r0
  end

  module AuthorName0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def b
      elements[3]
    end

    def space
      elements[4]
    end
  end

  module AuthorName1
    def value
      a.value + " " + b.value
    end
    
    def pos
      a.pos.merge(b.pos)
    end
    
    def details
      {:author => [a.value]}
    end
  end

  def _nt_author_name
    start_index = index
    if node_cache[:author_name].has_key?(index)
      cached = node_cache[:author_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      r3 = _nt_author_word
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          r5 = _nt_author_name
          s1 << r5
          if r5
            r6 = _nt_space
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(AuthorName0)
      r1.extend(AuthorName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_author_word
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:author_name][start_index] = r0

    return r0
  end

  module AuthorWord0
    def value
      text_value.strip
    end
    
    def pos
      {interval.begin => ['author_word', 1], (interval.begin + 2) => ['author_word', 2], (interval.begin + 5) => ['author_word', 2]}
    end
    
    def details
      {:author => [value]}
    end
  end

  module AuthorWord1
    def value
      text_value.strip
    end
    
    def pos
      #cheating because there are several words in some of them
      {interval.begin => ['author_word', interval.end]}
    end
    
    def details
      {:author => [value]}
    end
  end

  module AuthorWord2
  end

  module AuthorWord3
    def value
      text_value.gsub(/\s+/, " ").strip
    end
    
    def pos
      {interval.begin => ['author_word', interval.end]}
    end
    
    def details
      {:author => [value]}
    end
  end

  def _nt_author_word
    start_index = index
    if node_cache[:author_word].has_key?(index)
      cached = node_cache[:author_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("A S. Xu", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 7))
      r1.extend(AuthorWord0)
      @index += 7
    else
      terminal_parse_failure("A S. Xu")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2 = index
      if input.index("anon.", index) == index
        r3 = instantiate_node(SyntaxNode,input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("anon.")
        r3 = nil
      end
      if r3
        r2 = r3
        r2.extend(AuthorWord1)
      else
        if input.index("f.", index) == index
          r4 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("f.")
          r4 = nil
        end
        if r4
          r2 = r4
          r2.extend(AuthorWord1)
        else
          if input.index("bis", index) == index
            r5 = instantiate_node(SyntaxNode,input, index...(index + 3))
            @index += 3
          else
            terminal_parse_failure("bis")
            r5 = nil
          end
          if r5
            r2 = r5
            r2.extend(AuthorWord1)
          else
            if input.index("arg.", index) == index
              r6 = instantiate_node(SyntaxNode,input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure("arg.")
              r6 = nil
            end
            if r6
              r2 = r6
              r2.extend(AuthorWord1)
            else
              if input.index("da", index) == index
                r7 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("da")
                r7 = nil
              end
              if r7
                r2 = r7
                r2.extend(AuthorWord1)
              else
                if input.index("der", index) == index
                  r8 = instantiate_node(SyntaxNode,input, index...(index + 3))
                  @index += 3
                else
                  terminal_parse_failure("der")
                  r8 = nil
                end
                if r8
                  r2 = r8
                  r2.extend(AuthorWord1)
                else
                  if input.index("den", index) == index
                    r9 = instantiate_node(SyntaxNode,input, index...(index + 3))
                    @index += 3
                  else
                    terminal_parse_failure("den")
                    r9 = nil
                  end
                  if r9
                    r2 = r9
                    r2.extend(AuthorWord1)
                  else
                    if input.index("de", index) == index
                      r10 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("de")
                      r10 = nil
                    end
                    if r10
                      r2 = r10
                      r2.extend(AuthorWord1)
                    else
                      if input.index("du", index) == index
                        r11 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("du")
                        r11 = nil
                      end
                      if r11
                        r2 = r11
                        r2.extend(AuthorWord1)
                      else
                        if input.index("la", index) == index
                          r12 = instantiate_node(SyntaxNode,input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("la")
                          r12 = nil
                        end
                        if r12
                          r2 = r12
                          r2.extend(AuthorWord1)
                        else
                          if input.index("ter", index) == index
                            r13 = instantiate_node(SyntaxNode,input, index...(index + 3))
                            @index += 3
                          else
                            terminal_parse_failure("ter")
                            r13 = nil
                          end
                          if r13
                            r2 = r13
                            r2.extend(AuthorWord1)
                          else
                            if input.index("van", index) == index
                              r14 = instantiate_node(SyntaxNode,input, index...(index + 3))
                              @index += 3
                            else
                              terminal_parse_failure("van")
                              r14 = nil
                            end
                            if r14
                              r2 = r14
                              r2.extend(AuthorWord1)
                            else
                              if input.index("et al.\{\?\}", index) == index
                                r15 = instantiate_node(SyntaxNode,input, index...(index + 9))
                                @index += 9
                              else
                                terminal_parse_failure("et al.\{\?\}")
                                r15 = nil
                              end
                              if r15
                                r2 = r15
                                r2.extend(AuthorWord1)
                              else
                                if input.index("et al.", index) == index
                                  r16 = instantiate_node(SyntaxNode,input, index...(index + 6))
                                  @index += 6
                                else
                                  terminal_parse_failure("et al.")
                                  r16 = nil
                                end
                                if r16
                                  r2 = r16
                                  r2.extend(AuthorWord1)
                                else
                                  self.index = i2
                                  r2 = nil
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      if r2
        r0 = r2
      else
        i17, s17 = index, []
        i18 = index
        if input.index("Å", index) == index
          r19 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("Å")
          r19 = nil
        end
        if r19
          r18 = r19
        else
          if input.index("Ö", index) == index
            r20 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("Ö")
            r20 = nil
          end
          if r20
            r18 = r20
          else
            if input.index("Á", index) == index
              r21 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("Á")
              r21 = nil
            end
            if r21
              r18 = r21
            else
              if input.index("Ø", index) == index
                r22 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("Ø")
                r22 = nil
              end
              if r22
                r18 = r22
              else
                if input.index("Ô", index) == index
                  r23 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure("Ô")
                  r23 = nil
                end
                if r23
                  r18 = r23
                else
                  if input.index("Š", index) == index
                    r24 = instantiate_node(SyntaxNode,input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("Š")
                    r24 = nil
                  end
                  if r24
                    r18 = r24
                  else
                    if input.index("Ś", index) == index
                      r25 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("Ś")
                      r25 = nil
                    end
                    if r25
                      r18 = r25
                    else
                      if input.index("Č", index) == index
                        r26 = instantiate_node(SyntaxNode,input, index...(index + 1))
                        @index += 1
                      else
                        terminal_parse_failure("Č")
                        r26 = nil
                      end
                      if r26
                        r18 = r26
                      else
                        if input.index("Ķ", index) == index
                          r27 = instantiate_node(SyntaxNode,input, index...(index + 1))
                          @index += 1
                        else
                          terminal_parse_failure("Ķ")
                          r27 = nil
                        end
                        if r27
                          r18 = r27
                        else
                          if input.index("Ł", index) == index
                            r28 = instantiate_node(SyntaxNode,input, index...(index + 1))
                            @index += 1
                          else
                            terminal_parse_failure("Ł")
                            r28 = nil
                          end
                          if r28
                            r18 = r28
                          else
                            if input.index("É", index) == index
                              r29 = instantiate_node(SyntaxNode,input, index...(index + 1))
                              @index += 1
                            else
                              terminal_parse_failure("É")
                              r29 = nil
                            end
                            if r29
                              r18 = r29
                            else
                              if input.index("Ž", index) == index
                                r30 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                @index += 1
                              else
                                terminal_parse_failure("Ž")
                                r30 = nil
                              end
                              if r30
                                r18 = r30
                              else
                                if input.index(Regexp.new('[A-Z]'), index) == index
                                  r31 = instantiate_node(SyntaxNode,input, index...(index + 1))
                                  @index += 1
                                else
                                  r31 = nil
                                end
                                if r31
                                  r18 = r31
                                else
                                  self.index = i18
                                  r18 = nil
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
        s17 << r18
        if r18
          s32, i32 = [], index
          loop do
            if input.index(Regexp.new('[^0-9()\\s&,]'), index) == index
              r33 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              r33 = nil
            end
            if r33
              s32 << r33
            else
              break
            end
          end
          if s32.empty?
            self.index = i32
            r32 = nil
          else
            r32 = instantiate_node(SyntaxNode,input, i32...index, s32)
          end
          s17 << r32
        end
        if s17.last
          r17 = instantiate_node(SyntaxNode,input, i17...index, s17)
          r17.extend(AuthorWord2)
          r17.extend(AuthorWord3)
        else
          self.index = i17
          r17 = nil
        end
        if r17
          r0 = r17
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:author_word][start_index] = r0

    return r0
  end

  module CapLatinWord0
    def a
      elements[0]
    end

    def b
      elements[1]
    end

  end

  module CapLatinWord1
    def value
      (a.value rescue a.text_value) + b.value
    end
  end

  module CapLatinWord2
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module CapLatinWord3
    def value
      (a.value rescue a.text_value) + b.value
    end
  end

  module CapLatinWord4
    def value
      text_value
    end
  end

  def _nt_cap_latin_word
    start_index = index
    if node_cache[:cap_latin_word].has_key?(index)
      cached = node_cache[:cap_latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    i2 = index
    if input.index(Regexp.new('[A-Z]'), index) == index
      r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r3 = nil
    end
    if r3
      r2 = r3
    else
      r4 = _nt_cap_digraph
      if r4
        r2 = r4
      else
        self.index = i2
        r2 = nil
      end
    end
    s1 << r2
    if r2
      r5 = _nt_latin_word
      s1 << r5
      if r5
        if input.index("?", index) == index
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("?")
          r6 = nil
        end
        s1 << r6
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(CapLatinWord0)
      r1.extend(CapLatinWord1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      i8 = index
      if input.index(Regexp.new('[A-Z]'), index) == index
        r9 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r9 = nil
      end
      if r9
        r8 = r9
      else
        r10 = _nt_cap_digraph
        if r10
          r8 = r10
        else
          self.index = i8
          r8 = nil
        end
      end
      s7 << r8
      if r8
        r11 = _nt_latin_word
        s7 << r11
      end
      if s7.last
        r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
        r7.extend(CapLatinWord2)
        r7.extend(CapLatinWord3)
      else
        self.index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        i12 = index
        if input.index("Ca", index) == index
          r13 = instantiate_node(SyntaxNode,input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("Ca")
          r13 = nil
        end
        if r13
          r12 = r13
          r12.extend(CapLatinWord4)
        else
          if input.index("Ea", index) == index
            r14 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("Ea")
            r14 = nil
          end
          if r14
            r12 = r14
            r12.extend(CapLatinWord4)
          else
            if input.index("Ge", index) == index
              r15 = instantiate_node(SyntaxNode,input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure("Ge")
              r15 = nil
            end
            if r15
              r12 = r15
              r12.extend(CapLatinWord4)
            else
              if input.index("Ia", index) == index
                r16 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("Ia")
                r16 = nil
              end
              if r16
                r12 = r16
                r12.extend(CapLatinWord4)
              else
                if input.index("Io", index) == index
                  r17 = instantiate_node(SyntaxNode,input, index...(index + 2))
                  @index += 2
                else
                  terminal_parse_failure("Io")
                  r17 = nil
                end
                if r17
                  r12 = r17
                  r12.extend(CapLatinWord4)
                else
                  if input.index("Io", index) == index
                    r18 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure("Io")
                    r18 = nil
                  end
                  if r18
                    r12 = r18
                    r12.extend(CapLatinWord4)
                  else
                    if input.index("Ix", index) == index
                      r19 = instantiate_node(SyntaxNode,input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("Ix")
                      r19 = nil
                    end
                    if r19
                      r12 = r19
                      r12.extend(CapLatinWord4)
                    else
                      if input.index("Lo", index) == index
                        r20 = instantiate_node(SyntaxNode,input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("Lo")
                        r20 = nil
                      end
                      if r20
                        r12 = r20
                        r12.extend(CapLatinWord4)
                      else
                        if input.index("Oa", index) == index
                          r21 = instantiate_node(SyntaxNode,input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("Oa")
                          r21 = nil
                        end
                        if r21
                          r12 = r21
                          r12.extend(CapLatinWord4)
                        else
                          if input.index("Ra", index) == index
                            r22 = instantiate_node(SyntaxNode,input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("Ra")
                            r22 = nil
                          end
                          if r22
                            r12 = r22
                            r12.extend(CapLatinWord4)
                          else
                            if input.index("Ty", index) == index
                              r23 = instantiate_node(SyntaxNode,input, index...(index + 2))
                              @index += 2
                            else
                              terminal_parse_failure("Ty")
                              r23 = nil
                            end
                            if r23
                              r12 = r23
                              r12.extend(CapLatinWord4)
                            else
                              if input.index("Ua", index) == index
                                r24 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                @index += 2
                              else
                                terminal_parse_failure("Ua")
                                r24 = nil
                              end
                              if r24
                                r12 = r24
                                r12.extend(CapLatinWord4)
                              else
                                if input.index("Aa", index) == index
                                  r25 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                  @index += 2
                                else
                                  terminal_parse_failure("Aa")
                                  r25 = nil
                                end
                                if r25
                                  r12 = r25
                                  r12.extend(CapLatinWord4)
                                else
                                  if input.index("Ja", index) == index
                                    r26 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                    @index += 2
                                  else
                                    terminal_parse_failure("Ja")
                                    r26 = nil
                                  end
                                  if r26
                                    r12 = r26
                                    r12.extend(CapLatinWord4)
                                  else
                                    if input.index("Zu", index) == index
                                      r27 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                      @index += 2
                                    else
                                      terminal_parse_failure("Zu")
                                      r27 = nil
                                    end
                                    if r27
                                      r12 = r27
                                      r12.extend(CapLatinWord4)
                                    else
                                      if input.index("La", index) == index
                                        r28 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                        @index += 2
                                      else
                                        terminal_parse_failure("La")
                                        r28 = nil
                                      end
                                      if r28
                                        r12 = r28
                                        r12.extend(CapLatinWord4)
                                      else
                                        if input.index("Qu", index) == index
                                          r29 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                          @index += 2
                                        else
                                          terminal_parse_failure("Qu")
                                          r29 = nil
                                        end
                                        if r29
                                          r12 = r29
                                          r12.extend(CapLatinWord4)
                                        else
                                          if input.index("As", index) == index
                                            r30 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                            @index += 2
                                          else
                                            terminal_parse_failure("As")
                                            r30 = nil
                                          end
                                          if r30
                                            r12 = r30
                                            r12.extend(CapLatinWord4)
                                          else
                                            if input.index("Ba", index) == index
                                              r31 = instantiate_node(SyntaxNode,input, index...(index + 2))
                                              @index += 2
                                            else
                                              terminal_parse_failure("Ba")
                                              r31 = nil
                                            end
                                            if r31
                                              r12 = r31
                                              r12.extend(CapLatinWord4)
                                            else
                                              self.index = i12
                                              r12 = nil
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
        if r12
          r0 = r12
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:cap_latin_word][start_index] = r0

    return r0
  end

  module LatinWord0
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module LatinWord1
    def value
      a.text_value + b.value
    end
  end

  module LatinWord2
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module LatinWord3
    def value
      a.value + b.value
    end
  end

  def _nt_latin_word
    start_index = index
    if node_cache[:latin_word].has_key?(index)
      cached = node_cache[:latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index(Regexp.new('[a-zëüäöïé]'), index) == index
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_full_name_letters
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(LatinWord0)
      r1.extend(LatinWord1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i4, s4 = index, []
      r5 = _nt_digraph
      s4 << r5
      if r5
        r6 = _nt_full_name_letters
        s4 << r6
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(LatinWord2)
        r4.extend(LatinWord3)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:latin_word][start_index] = r0

    return r0
  end

  module FullNameLetters0
    def a
      elements[0]
    end

    def b
      elements[1]
    end
  end

  module FullNameLetters1
    def value
      a.value + b.value
    end
  end

  module FullNameLetters2
    def a
      elements[0]
    end

    def b
      elements[1]
    end

    def c
      elements[2]
    end
  end

  module FullNameLetters3
    def value
      a.value + b.value + c.value
    end
  end

  def _nt_full_name_letters
    start_index = index
    if node_cache[:full_name_letters].has_key?(index)
      cached = node_cache[:full_name_letters][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_digraph
    s1 << r2
    if r2
      r3 = _nt_full_name_letters
      s1 << r3
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(FullNameLetters0)
      r1.extend(FullNameLetters1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i4, s4 = index, []
      r5 = _nt_valid_name_letters
      s4 << r5
      if r5
        r6 = _nt_digraph
        s4 << r6
        if r6
          r7 = _nt_full_name_letters
          s4 << r7
        end
      end
      if s4.last
        r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        r4.extend(FullNameLetters2)
        r4.extend(FullNameLetters3)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        r0 = r4
      else
        r8 = _nt_valid_name_letters
        if r8
          r0 = r8
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:full_name_letters][start_index] = r0

    return r0
  end

  module ValidNameLetters0
    def value
      text_value
    end
  end

  def _nt_valid_name_letters
    start_index = index
    if node_cache[:valid_name_letters].has_key?(index)
      cached = node_cache[:valid_name_letters][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[a-z\\-ëüäöïé]'), index) == index
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(ValidNameLetters0)
    end

    node_cache[:valid_name_letters][start_index] = r0

    return r0
  end

  module CapDigraph0
    def value
    'Ae'
    end
  end

  module CapDigraph1
    def value
    'Oe'
    end
  end

  def _nt_cap_digraph
    start_index = index
    if node_cache[:cap_digraph].has_key?(index)
      cached = node_cache[:cap_digraph][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("Æ", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      r1.extend(CapDigraph0)
      @index += 1
    else
      terminal_parse_failure("Æ")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index("Œ", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        r2.extend(CapDigraph1)
        @index += 1
      else
        terminal_parse_failure("Œ")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:cap_digraph][start_index] = r0

    return r0
  end

  module Digraph0
    def value
    'ae'
    end
  end

  module Digraph1
    def value
    'oe'
    end
  end

  def _nt_digraph
    start_index = index
    if node_cache[:digraph].has_key?(index)
      cached = node_cache[:digraph][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("æ", index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      r1.extend(Digraph0)
      @index += 1
    else
      terminal_parse_failure("æ")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index("œ", index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        r2.extend(Digraph1)
        @index += 1
      else
        terminal_parse_failure("œ")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:digraph][start_index] = r0

    return r0
  end

  def _nt_year
    start_index = index
    if node_cache[:year].has_key?(index)
      cached = node_cache[:year][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_year_number_with_character
    if r1
      r0 = r1
    else
      r2 = _nt_year_number
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:year][start_index] = r0

    return r0
  end

  module YearNumberWithCharacter0
    def a
      elements[0]
    end

  end

  module YearNumberWithCharacter1
    def value
      a.text_value
    end

    def pos
      {interval.begin => ['year', interval.end]}
    end

    def details
      {:year => value}
    end
  end

  def _nt_year_number_with_character
    start_index = index
    if node_cache[:year_number_with_character].has_key?(index)
      cached = node_cache[:year_number_with_character][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_year_number
    s0 << r1
    if r1
      if input.index(Regexp.new('[a-zA-Z]'), index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearNumberWithCharacter0)
      r0.extend(YearNumberWithCharacter1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:year_number_with_character][start_index] = r0

    return r0
  end

  module YearNumber0
  end

  module YearNumber1
    def value
      text_value
    end
    
    def pos
      {interval.begin => ['year', interval.end]}
    end
    
    def details
      {:year => value}
    end
  end

  def _nt_year_number
    start_index = index
    if node_cache[:year_number].has_key?(index)
      cached = node_cache[:year_number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[12]'), index) == index
      r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[7890]'), index) == index
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        if input.index(Regexp.new('[0-9]'), index) == index
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        s0 << r3
        if r3
          if input.index(Regexp.new('[0-9\\?]'), index) == index
            r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            r4 = nil
          end
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(YearNumber0)
      r0.extend(YearNumber1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:year_number][start_index] = r0

    return r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[\\s]'), index) == index
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:space][start_index] = r0

    return r0
  end

  def _nt_space_hard
    start_index = index
    if node_cache[:space_hard].has_key?(index)
      cached = node_cache[:space_hard][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[\\s]'), index) == index
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:space_hard][start_index] = r0

    return r0
  end

end

class ScientificNameCleanParser < Treetop::Runtime::CompiledParser
  include ScientificNameClean
end
