module ScientificName
  include Treetop::Runtime

  def root
    @root || :composite_scientific_name
  end

  module CompositeScientificName0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def hybrid_separator
      elements[2]
    end

    def space
      elements[3]
    end

    def b
      elements[4]
    end

    def space
      elements[5]
    end
  end

  module CompositeScientificName1
    def value
      a.value + " × " + b.value
    end
    def canonical
      a.canonical + " × " + b.canonical
    end
    def details
      {:hybrid => {:scientific_name1 => a.details, :scientific_name2 => b.details}}
    end
  end

  module CompositeScientificName2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def hybrid_separator
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module CompositeScientificName3
    def value
      a.value + " × ?"
    end
    
    def canonical
      a.canonical
    end
    
    def details
      {:hybrid => {:scientific_name1 => a.details, :scientific_name2 => "?"}}
    end
  end

  def _nt_composite_scientific_name
    start_index = index
    if node_cache[:composite_scientific_name].has_key?(index)
      cached = node_cache[:composite_scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_scientific_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_hybrid_separator
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_scientific_name
            s1 << r6
            if r6
              r7 = _nt_space
              s1 << r7
            end
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(CompositeScientificName0)
      r1.extend(CompositeScientificName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i8, s8 = index, []
      r9 = _nt_scientific_name
      s8 << r9
      if r9
        r10 = _nt_space
        s8 << r10
        if r10
          r11 = _nt_hybrid_separator
          s8 << r11
          if r11
            r12 = _nt_space
            s8 << r12
            if r12
              if input.index(Regexp.new('[\\?]'), index) == index
                r14 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                r14 = nil
              end
              if r14
                r13 = r14
              else
                r13 = SyntaxNode.new(input, index...index)
              end
              s8 << r13
            end
          end
        end
      end
      if s8.last
        r8 = (SyntaxNode).new(input, i8...index, s8)
        r8.extend(CompositeScientificName2)
        r8.extend(CompositeScientificName3)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        r15 = _nt_scientific_name
        if r15
          r0 = r15
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:composite_scientific_name][start_index] = r0

    return r0
  end

  module ScientificName0
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

    def c
      elements[5]
    end

    def space
      elements[6]
    end
  end

  module ScientificName1
    def value
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module ScientificName2
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

  module ScientificName3
    def value
      a.value + " " + b.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details.merge(b.details)
    end
  end

  module ScientificName4
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

  module ScientificName5
    def value
      a.value + " " + b.value
    end
    
    def canonical
      a.canonical
    end
    
    def details
      a.details.merge(b.details).merge({:is_valid => false})
    end
  end

  def _nt_scientific_name
    start_index = index
    if node_cache[:scientific_name].has_key?(index)
      cached = node_cache[:scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_name_part_authors_mix
    if r1
      r0 = r1
    else
      i2, s2 = index, []
      r3 = _nt_space
      s2 << r3
      if r3
        r4 = _nt_name_part
        s2 << r4
        if r4
          r5 = _nt_space
          s2 << r5
          if r5
            r6 = _nt_authors_part
            s2 << r6
            if r6
              r7 = _nt_space
              s2 << r7
              if r7
                r8 = _nt_status_part
                s2 << r8
                if r8
                  r9 = _nt_space
                  s2 << r9
                end
              end
            end
          end
        end
      end
      if s2.last
        r2 = (SyntaxNode).new(input, i2...index, s2)
        r2.extend(ScientificName0)
        r2.extend(ScientificName1)
      else
        self.index = i2
        r2 = nil
      end
      if r2
        r0 = r2
      else
        i10, s10 = index, []
        r11 = _nt_space
        s10 << r11
        if r11
          r12 = _nt_name_part
          s10 << r12
          if r12
            r13 = _nt_space
            s10 << r13
            if r13
              r14 = _nt_authors_part
              s10 << r14
              if r14
                r15 = _nt_space
                s10 << r15
              end
            end
          end
        end
        if s10.last
          r10 = (SyntaxNode).new(input, i10...index, s10)
          r10.extend(ScientificName2)
          r10.extend(ScientificName3)
        else
          self.index = i10
          r10 = nil
        end
        if r10
          r0 = r10
        else
          i16, s16 = index, []
          r17 = _nt_space
          s16 << r17
          if r17
            r18 = _nt_name_part
            s16 << r18
            if r18
              r19 = _nt_space
              s16 << r19
              if r19
                r20 = _nt_year
                s16 << r20
                if r20
                  r21 = _nt_space
                  s16 << r21
                end
              end
            end
          end
          if s16.last
            r16 = (SyntaxNode).new(input, i16...index, s16)
            r16.extend(ScientificName4)
            r16.extend(ScientificName5)
          else
            self.index = i16
            r16 = nil
          end
          if r16
            r0 = r16
          else
            r22 = _nt_name_part
            if r22
              r0 = r22
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:scientific_name][start_index] = r0

    return r0
  end

  module StatusPart0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module StatusPart1
    def value
      a.value + " " + b.value
    end
    def details
      {:status => value}
    end
  end

  def _nt_status_part
    start_index = index
    if node_cache[:status_part].has_key?(index)
      cached = node_cache[:status_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_status_word
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_status_part
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(StatusPart0)
      r1.extend(StatusPart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_status_word
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:status_part][start_index] = r0

    return r0
  end

  module StatusWord0
    def latin_word
      elements[0]
    end

  end

  module StatusWord1
    def value
      text_value.strip
    end
    def details
      {:status => value}
    end
  end

  def _nt_status_word
    start_index = index
    if node_cache[:status_word].has_key?(index)
      cached = node_cache[:status_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_latin_word
    s1 << r2
    if r2
      if input.index(Regexp.new('[\\.]'), index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r3 = nil
      end
      s1 << r3
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(StatusWord0)
      r1.extend(StatusWord1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r4 = _nt_latin_word
      if r4
        r0 = r4
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:status_word][start_index] = r0

    return r0
  end

  module NamePartAuthorsMix0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end

    def space
      elements[3]
    end

    def c
      elements[4]
    end

    def space
      elements[5]
    end

    def d
      elements[6]
    end
  end

  module NamePartAuthorsMix1
    def value
      a.value + " " + b.value + " " + c.value + " " + d.value
    end
    def canonical
      a.canonical + " " + c.canonical
    end
    def details
      a.details.merge(c.details).merge({:species_authors=>b.details, :subspecies_authors => d.details})
    end
  end

  module NamePartAuthorsMix2
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end

    def space
      elements[3]
    end

    def c
      elements[4]
    end
  end

  module NamePartAuthorsMix3
    def value 
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.canonical + " " + c.canonical
    end
    def details
      a.details.merge(c.details).merge({:species_authors=>b.details})
    end
  end

  def _nt_name_part_authors_mix
    start_index = index
    if node_cache[:name_part_authors_mix].has_key?(index)
      cached = node_cache[:name_part_authors_mix][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_species_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_authors_part
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_subspecies_name
            s1 << r6
            if r6
              r7 = _nt_space
              s1 << r7
              if r7
                r8 = _nt_authors_part
                s1 << r8
              end
            end
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(NamePartAuthorsMix0)
      r1.extend(NamePartAuthorsMix1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_species_name
      s9 << r10
      if r10
        r11 = _nt_space
        s9 << r11
        if r11
          r12 = _nt_authors_part
          s9 << r12
          if r12
            r13 = _nt_space
            s9 << r13
            if r13
              r14 = _nt_subspecies_name
              s9 << r14
            end
          end
        end
      end
      if s9.last
        r9 = (SyntaxNode).new(input, i9...index, s9)
        r9.extend(NamePartAuthorsMix2)
        r9.extend(NamePartAuthorsMix3)
      else
        self.index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:name_part_authors_mix][start_index] = r0

    return r0
  end

  module AuthorsPart0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module AuthorsPart1
    def value 
      a.value + " " + b.value
    end
  
    def details
      a.details.merge(b.details)
    end
  end

  module AuthorsPart2
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

  module AuthorsPart3
    def value 
      a.value + " ex " + b.value
    end
    
    def details
      {:revised_name_authors => {:revised_authors => a.details[:authors], :authors => b.details[:authors]}}
    end
  end

  module AuthorsPart4
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module AuthorsPart5
    def value
      a.value + " " + b.value
    end
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_authors_part
    start_index = index
    if node_cache[:authors_part].has_key?(index)
      cached = node_cache[:authors_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_original_authors_revised_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_authors_revised_name
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(AuthorsPart0)
      r1.extend(AuthorsPart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i5, s5 = index, []
      r6 = _nt_simple_authors_part
      s5 << r6
      if r6
        r7 = _nt_space
        s5 << r7
        if r7
          if input.index("ex", index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("ex")
            r8 = nil
          end
          s5 << r8
          if r8
            r9 = _nt_space
            s5 << r9
            if r9
              r10 = _nt_simple_authors_part
              s5 << r10
            end
          end
        end
      end
      if s5.last
        r5 = (SyntaxNode).new(input, i5...index, s5)
        r5.extend(AuthorsPart2)
        r5.extend(AuthorsPart3)
      else
        self.index = i5
        r5 = nil
      end
      if r5
        r0 = r5
      else
        i11, s11 = index, []
        r12 = _nt_original_authors_revised_name
        s11 << r12
        if r12
          r13 = _nt_space
          s11 << r13
          if r13
            r14 = _nt_authors_full
            s11 << r14
          end
        end
        if s11.last
          r11 = (SyntaxNode).new(input, i11...index, s11)
          r11.extend(AuthorsPart4)
          r11.extend(AuthorsPart5)
        else
          self.index = i11
          r11 = nil
        end
        if r11
          r0 = r11
        else
          r15 = _nt_authors_revised_name
          if r15
            r0 = r15
          else
            r16 = _nt_original_authors_revised_name
            if r16
              r0 = r16
            else
              r17 = _nt_simple_authors_part
              if r17
                r0 = r17
              else
                self.index = i0
                r0 = nil
              end
            end
          end
        end
      end
    end

    node_cache[:authors_part][start_index] = r0

    return r0
  end

  module SimpleAuthorsPart0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module SimpleAuthorsPart1
    def value
      a.value + " " + b.value
    end
    def details
      a.details.merge(b.details)
    end
  end

  def _nt_simple_authors_part
    start_index = index
    if node_cache[:simple_authors_part].has_key?(index)
      cached = node_cache[:simple_authors_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_original_authors_full
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_authors_full
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SimpleAuthorsPart0)
      r1.extend(SimpleAuthorsPart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_original_authors_full
      if r5
        r0 = r5
      else
        r6 = _nt_authors_full
        if r6
          r0 = r6
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:simple_authors_part][start_index] = r0

    return r0
  end

  module OriginalAuthorsFull0
    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module OriginalAuthorsFull1
    def value
      "(" + a.value + ")"
    end
    def details
      {:orig_authors => a.details[:authors]}
    end
  end

  def _nt_original_authors_full
    start_index = index
    if node_cache[:original_authors_full].has_key?(index)
      cached = node_cache[:original_authors_full][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_authors_full
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(OriginalAuthorsFull0)
      r0.extend(OriginalAuthorsFull1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:original_authors_full][start_index] = r0

    return r0
  end

  module OriginalAuthorsRevisedName0
    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module OriginalAuthorsRevisedName1
    def value
      "(" + a.value + ")"
    end
    
    def details
      {:original_revised_name_authors => a.details[:revised_name_authors]}
    end
  end

  def _nt_original_authors_revised_name
    start_index = index
    if node_cache[:original_authors_revised_name].has_key?(index)
      cached = node_cache[:original_authors_revised_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_authors_revised_name
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(OriginalAuthorsRevisedName0)
      r0.extend(OriginalAuthorsRevisedName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:original_authors_revised_name][start_index] = r0

    return r0
  end

  module AuthorsRevisedName0
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

  module AuthorsRevisedName1
    def value
      a.value + " ex " + b.value
    end
    def details
      {:revised_name_authors =>{:revised_authors => a.details[:authors], :authors => b.details[:authors]}}
    end
  end

  def _nt_authors_revised_name
    start_index = index
    if node_cache[:authors_revised_name].has_key?(index)
      cached = node_cache[:authors_revised_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_authors_full
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        if input.index("ex", index) == index
          r3 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("ex")
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            r5 = _nt_authors_full
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(AuthorsRevisedName0)
      r0.extend(AuthorsRevisedName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:authors_revised_name][start_index] = r0

    return r0
  end

  module AuthorsFull0
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

  module AuthorsFull1
    def value 
      a.value + " " + b.value
    end
    def details
      {:authors => {:names => a.details[:authors][:names]}.merge(b.details)}
    end
  end

  def _nt_authors_full
    start_index = index
    if node_cache[:authors_full].has_key?(index)
      cached = node_cache[:authors_full][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_authors
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        if input.index(Regexp.new('[,]'), index) == index
          r5 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r5 = nil
        end
        if r5
          r4 = r5
        else
          r4 = SyntaxNode.new(input, index...index)
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
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(AuthorsFull0)
      r1.extend(AuthorsFull1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r8 = _nt_authors
      if r8
        r0 = r8
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors_full][start_index] = r0

    return r0
  end

  module Authors0
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

  module Authors1
    def value
      sep.apply(a,b)
    end
    
    def details
      sep.details(a,b)
    end
  end

  def _nt_authors
    start_index = index
    if node_cache[:authors].has_key?(index)
      cached = node_cache[:authors][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_author
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_authors_separator
        s1 << r4
        if r4
          r5 = _nt_space
          s1 << r5
          if r5
            r6 = _nt_authors
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Authors0)
      r1.extend(Authors1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r7 = _nt_author
      if r7
        r0 = r7
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors][start_index] = r0

    return r0
  end

  module AuthorsSeparator0
    def apply(a,b)
      sep = text_value.strip
      sep = " " + sep if sep == "&"
      a.value + sep + " " + b.value
    end

    def details(a,b)
      {:authors => {:names => a.details[:authors][:names] + b.details[:authors][:names]}}
    end
  end

  def _nt_authors_separator
    start_index = index
    if node_cache[:authors_separator].has_key?(index)
      cached = node_cache[:authors_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("&", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("&")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(AuthorsSeparator0)
    else
      if input.index(",", index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(",")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(AuthorsSeparator0)
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors_separator][start_index] = r0

    return r0
  end

  module Author0
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

  module Author1
    def value
      a.value + " " + b.value
    end

    def details
      {:authors => {:names => [value]}}
    end
  end

  def _nt_author
    start_index = index
    if node_cache[:author].has_key?(index)
      cached = node_cache[:author][index]
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
          r5 = _nt_author
          s1 << r5
          if r5
            r6 = _nt_space
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Author0)
      r1.extend(Author1)
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

    node_cache[:author][start_index] = r0

    return r0
  end

  module AuthorWord0
    def value
      text_value.strip
    end
    def details
      {:authors => {:names => [value]}}
    end
  end

  module AuthorWord1
  end

  module AuthorWord2
    def value
      text_value.gsub(/\s+/, " ").strip
    end
    def details
      {:authors => {:names => [value]}}
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
      r1 = (SyntaxNode).new(input, index...(index + 7))
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
        r3 = (SyntaxNode).new(input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("anon.")
        r3 = nil
      end
      if r3
        r2 = r3
        r2.extend(AuthorWord0)
      else
        if input.index("f.", index) == index
          r4 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("f.")
          r4 = nil
        end
        if r4
          r2 = r4
          r2.extend(AuthorWord0)
        else
          if input.index("bis", index) == index
            r5 = (SyntaxNode).new(input, index...(index + 3))
            @index += 3
          else
            terminal_parse_failure("bis")
            r5 = nil
          end
          if r5
            r2 = r5
            r2.extend(AuthorWord0)
          else
            if input.index("arg.", index) == index
              r6 = (SyntaxNode).new(input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure("arg.")
              r6 = nil
            end
            if r6
              r2 = r6
              r2.extend(AuthorWord0)
            else
              if input.index("da", index) == index
                r7 = (SyntaxNode).new(input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("da")
                r7 = nil
              end
              if r7
                r2 = r7
                r2.extend(AuthorWord0)
              else
                if input.index("der", index) == index
                  r8 = (SyntaxNode).new(input, index...(index + 3))
                  @index += 3
                else
                  terminal_parse_failure("der")
                  r8 = nil
                end
                if r8
                  r2 = r8
                  r2.extend(AuthorWord0)
                else
                  if input.index("den", index) == index
                    r9 = (SyntaxNode).new(input, index...(index + 3))
                    @index += 3
                  else
                    terminal_parse_failure("den")
                    r9 = nil
                  end
                  if r9
                    r2 = r9
                    r2.extend(AuthorWord0)
                  else
                    if input.index("de", index) == index
                      r10 = (SyntaxNode).new(input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("de")
                      r10 = nil
                    end
                    if r10
                      r2 = r10
                      r2.extend(AuthorWord0)
                    else
                      if input.index("du", index) == index
                        r11 = (SyntaxNode).new(input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("du")
                        r11 = nil
                      end
                      if r11
                        r2 = r11
                        r2.extend(AuthorWord0)
                      else
                        if input.index("in", index) == index
                          r12 = (SyntaxNode).new(input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("in")
                          r12 = nil
                        end
                        if r12
                          r2 = r12
                          r2.extend(AuthorWord0)
                        else
                          if input.index("la", index) == index
                            r13 = (SyntaxNode).new(input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("la")
                            r13 = nil
                          end
                          if r13
                            r2 = r13
                            r2.extend(AuthorWord0)
                          else
                            if input.index("ter", index) == index
                              r14 = (SyntaxNode).new(input, index...(index + 3))
                              @index += 3
                            else
                              terminal_parse_failure("ter")
                              r14 = nil
                            end
                            if r14
                              r2 = r14
                              r2.extend(AuthorWord0)
                            else
                              if input.index("van", index) == index
                                r15 = (SyntaxNode).new(input, index...(index + 3))
                                @index += 3
                              else
                                terminal_parse_failure("van")
                                r15 = nil
                              end
                              if r15
                                r2 = r15
                                r2.extend(AuthorWord0)
                              else
                                if input.index("von", index) == index
                                  r16 = (SyntaxNode).new(input, index...(index + 3))
                                  @index += 3
                                else
                                  terminal_parse_failure("von")
                                  r16 = nil
                                end
                                if r16
                                  r2 = r16
                                  r2.extend(AuthorWord0)
                                else
                                  if input.index("al.", index) == index
                                    r17 = (SyntaxNode).new(input, index...(index + 3))
                                    @index += 3
                                  else
                                    terminal_parse_failure("al.")
                                    r17 = nil
                                  end
                                  if r17
                                    r2 = r17
                                    r2.extend(AuthorWord0)
                                  else
                                    if input.index("et al.\{\?\}", index) == index
                                      r18 = (SyntaxNode).new(input, index...(index + 9))
                                      @index += 9
                                    else
                                      terminal_parse_failure("et al.\{\?\}")
                                      r18 = nil
                                    end
                                    if r18
                                      r2 = r18
                                      r2.extend(AuthorWord0)
                                    else
                                      if input.index("et al.", index) == index
                                        r19 = (SyntaxNode).new(input, index...(index + 6))
                                        @index += 6
                                      else
                                        terminal_parse_failure("et al.")
                                        r19 = nil
                                      end
                                      if r19
                                        r2 = r19
                                        r2.extend(AuthorWord0)
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
          end
        end
      end
      if r2
        r0 = r2
      else
        i20, s20 = index, []
        if input.index("d\'", index) == index
          r22 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("d\'")
          r22 = nil
        end
        if r22
          r21 = r22
        else
          r21 = SyntaxNode.new(input, index...index)
        end
        s20 << r21
        if r21
          i23 = index
          if input.index("Å", index) == index
            r24 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("Å")
            r24 = nil
          end
          if r24
            r23 = r24
          else
            if input.index("Ö", index) == index
              r25 = (SyntaxNode).new(input, index...(index + 2))
              @index += 2
            else
              terminal_parse_failure("Ö")
              r25 = nil
            end
            if r25
              r23 = r25
            else
              if input.index("Á", index) == index
                r26 = (SyntaxNode).new(input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure("Á")
                r26 = nil
              end
              if r26
                r23 = r26
              else
                if input.index("Ø", index) == index
                  r27 = (SyntaxNode).new(input, index...(index + 2))
                  @index += 2
                else
                  terminal_parse_failure("Ø")
                  r27 = nil
                end
                if r27
                  r23 = r27
                else
                  if input.index("Ô", index) == index
                    r28 = (SyntaxNode).new(input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure("Ô")
                    r28 = nil
                  end
                  if r28
                    r23 = r28
                  else
                    if input.index("Š", index) == index
                      r29 = (SyntaxNode).new(input, index...(index + 2))
                      @index += 2
                    else
                      terminal_parse_failure("Š")
                      r29 = nil
                    end
                    if r29
                      r23 = r29
                    else
                      if input.index("Ś", index) == index
                        r30 = (SyntaxNode).new(input, index...(index + 2))
                        @index += 2
                      else
                        terminal_parse_failure("Ś")
                        r30 = nil
                      end
                      if r30
                        r23 = r30
                      else
                        if input.index("Č", index) == index
                          r31 = (SyntaxNode).new(input, index...(index + 2))
                          @index += 2
                        else
                          terminal_parse_failure("Č")
                          r31 = nil
                        end
                        if r31
                          r23 = r31
                        else
                          if input.index("Ķ", index) == index
                            r32 = (SyntaxNode).new(input, index...(index + 2))
                            @index += 2
                          else
                            terminal_parse_failure("Ķ")
                            r32 = nil
                          end
                          if r32
                            r23 = r32
                          else
                            if input.index("Ł", index) == index
                              r33 = (SyntaxNode).new(input, index...(index + 2))
                              @index += 2
                            else
                              terminal_parse_failure("Ł")
                              r33 = nil
                            end
                            if r33
                              r23 = r33
                            else
                              if input.index("É", index) == index
                                r34 = (SyntaxNode).new(input, index...(index + 2))
                                @index += 2
                              else
                                terminal_parse_failure("É")
                                r34 = nil
                              end
                              if r34
                                r23 = r34
                              else
                                if input.index("Ž", index) == index
                                  r35 = (SyntaxNode).new(input, index...(index + 2))
                                  @index += 2
                                else
                                  terminal_parse_failure("Ž")
                                  r35 = nil
                                end
                                if r35
                                  r23 = r35
                                else
                                  if input.index(Regexp.new('[A-Z]'), index) == index
                                    r36 = (SyntaxNode).new(input, index...(index + 1))
                                    @index += 1
                                  else
                                    r36 = nil
                                  end
                                  if r36
                                    r23 = r36
                                  else
                                    self.index = i23
                                    r23 = nil
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
          s20 << r23
          if r23
            s37, i37 = [], index
            loop do
              if input.index(Regexp.new('[^0-9()\\s&,]'), index) == index
                r38 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                r38 = nil
              end
              if r38
                s37 << r38
              else
                break
              end
            end
            if s37.empty?
              self.index = i37
              r37 = nil
            else
              r37 = SyntaxNode.new(input, i37...index, s37)
            end
            s20 << r37
          end
        end
        if s20.last
          r20 = (SyntaxNode).new(input, i20...index, s20)
          r20.extend(AuthorWord1)
          r20.extend(AuthorWord2)
        else
          self.index = i20
          r20 = nil
        end
        if r20
          r0 = r20
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:author_word][start_index] = r0

    return r0
  end

  module NamePart0
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

    def space_hard
      elements[4]
    end

    def c
      elements[5]
    end
  end

  module NamePart1
    def value
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.canonical
    end
    def details
      a.details.merge(b.details).merge(c.details)
    end
  end

  module NamePart2
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
  end

  module NamePart3
    def value
      a.value + b.value
    end
    def canonical
      a.canonical + b.canonical
    end
    
    def details
      a.details.merge(b.details)
    end
  end

  module NamePart4
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

  end

  module NamePart5
    def value
      a.value + " " + b.value
    end
    
    def canonical
      value
    end
    
    def details
      a.details.merge({:subspecies => {:rank => "n/a", :value =>b.value}})
    end
  end

  def _nt_name_part
    start_index = index
    if node_cache[:name_part].has_key?(index)
      cached = node_cache[:name_part][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      r3 = _nt_species_name
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          r5 = _nt_rank
          s1 << r5
          if r5
            r6 = _nt_space_hard
            s1 << r6
            if r6
              r7 = _nt_editorials_full
              s1 << r7
            end
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(NamePart0)
      r1.extend(NamePart1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i8, s8 = index, []
      r9 = _nt_space
      s8 << r9
      if r9
        r10 = _nt_species_name
        s8 << r10
        if r10
          r11 = _nt_space
          s8 << r11
          if r11
            r12 = _nt_subspecies_names
            s8 << r12
          end
        end
      end
      if s8.last
        r8 = (SyntaxNode).new(input, i8...index, s8)
        r8.extend(NamePart2)
        r8.extend(NamePart3)
      else
        self.index = i8
        r8 = nil
      end
      if r8
        r0 = r8
      else
        i13, s13 = index, []
        r14 = _nt_space
        s13 << r14
        if r14
          r15 = _nt_species_name
          s13 << r15
          if r15
            r16 = _nt_space
            s13 << r16
            if r16
              r17 = _nt_latin_word
              s13 << r17
              if r17
                i18 = index
                if input.index(Regexp.new('[^\\.]'), index) == index
                  r19 = (SyntaxNode).new(input, index...(index + 1))
                  @index += 1
                else
                  r19 = nil
                end
                if r19
                  self.index = i18
                  r18 = SyntaxNode.new(input, index...index)
                else
                  r18 = nil
                end
                s13 << r18
              end
            end
          end
        end
        if s13.last
          r13 = (SyntaxNode).new(input, i13...index, s13)
          r13.extend(NamePart4)
          r13.extend(NamePart5)
        else
          self.index = i13
          r13 = nil
        end
        if r13
          r0 = r13
        else
          r20 = _nt_species_name
          if r20
            r0 = r20
          else
            r21 = _nt_cap_latin_word
            if r21
              r0 = r21
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:name_part][start_index] = r0

    return r0
  end

  module SubspeciesNames0
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end
  end

  module SubspeciesNames1
    def value
      a.value + b.value
    end
    
    def canonical
      a.canonical + b.canonical
    end
    
    def details
      c = a.details[:infraspecies] + b.details_infraspecies
      a.details.merge({:infraspecies => c, :is_valid => false})
    end
  end

  def _nt_subspecies_names
    start_index = index
    if node_cache[:subspecies_names].has_key?(index)
      cached = node_cache[:subspecies_names][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_subspecies_name
    s1 << r2
    if r2
      r3 = _nt_space
      s1 << r3
      if r3
        r4 = _nt_subspecies_names
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SubspeciesNames0)
      r1.extend(SubspeciesNames1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = _nt_subspecies_name
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:subspecies_names][start_index] = r0

    return r0
  end

  module SubspeciesName0
    def sel
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def a
      elements[2]
    end
  end

  module SubspeciesName1
    def value 
      sel.apply(a)
    end
    def canonical
      sel.canonical(a)
    end
    def details
      sel.details(a)
    end
    def details_infraspecies
      details[:infraspecies]
    end
  end

  def _nt_subspecies_name
    start_index = index
    if node_cache[:subspecies_name].has_key?(index)
      cached = node_cache[:subspecies_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_rank
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
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SubspeciesName0)
      r0.extend(SubspeciesName1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:subspecies_name][start_index] = r0

    return r0
  end

  module EditorialsFull0
    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module EditorialsFull1
    def value
      "(" + a.value + ")"
    end
    def details
      {:editorial_markup => value, :is_valid => false}
    end
  end

  def _nt_editorials_full
    start_index = index
    if node_cache[:editorials_full].has_key?(index)
      cached = node_cache[:editorials_full][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_editorials
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(EditorialsFull0)
      r0.extend(EditorialsFull1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:editorials_full][start_index] = r0

    return r0
  end

  module Editorials0
    def space
      elements[0]
    end

    def a
      elements[1]
    end

    def space
      elements[2]
    end

    def space
      elements[4]
    end

    def b
      elements[5]
    end
  end

  module Editorials1
    def value
      a.value + b.value
    end
  end

  def _nt_editorials
    start_index = index
    if node_cache[:editorials].has_key?(index)
      cached = node_cache[:editorials][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_space
    s1 << r2
    if r2
      r3 = _nt_rank
      s1 << r3
      if r3
        r4 = _nt_space
        s1 << r4
        if r4
          if input.index(Regexp.new('[&]'), index) == index
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r6 = nil
          end
          if r6
            r5 = r6
          else
            r5 = SyntaxNode.new(input, index...index)
          end
          s1 << r5
          if r5
            r7 = _nt_space
            s1 << r7
            if r7
              r8 = _nt_editorials
              s1 << r8
            end
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Editorials0)
      r1.extend(Editorials1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r9 = _nt_rank
      if r9
        r0 = r9
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:editorials][start_index] = r0

    return r0
  end

  module Rank0
    def space
      elements[0]
    end

    def latin_word
      elements[1]
    end
  end

  module Rank1
  end

  module Rank2
    def value
      text_value.strip
    end
    def apply(a)
      " " + text_value + " " + a.value
    end
    def canonical(a)
      " " + a.value
    end
    def details(a = nil)
      {:infraspecies => [{:rank => text_value, :value => (a.value rescue nil)}]}
    end
  end

  def _nt_rank
    start_index = index
    if node_cache[:rank].has_key?(index)
      cached = node_cache[:rank][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("forma", index) == index
      r2 = (SyntaxNode).new(input, index...(index + 5))
      @index += 5
    else
      terminal_parse_failure("forma")
      r2 = nil
    end
    s1 << r2
    if r2
      i3 = index
      i4, s4 = index, []
      r5 = _nt_space
      s4 << r5
      if r5
        r6 = _nt_latin_word
        s4 << r6
      end
      if s4.last
        r4 = (SyntaxNode).new(input, i4...index, s4)
        r4.extend(Rank0)
      else
        self.index = i4
        r4 = nil
      end
      if r4
        self.index = i3
        r3 = SyntaxNode.new(input, index...index)
      else
        r3 = nil
      end
      s1 << r3
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Rank1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(Rank2)
    else
      if input.index("f.sp.", index) == index
        r7 = (SyntaxNode).new(input, index...(index + 5))
        @index += 5
      else
        terminal_parse_failure("f.sp.")
        r7 = nil
      end
      if r7
        r0 = r7
        r0.extend(Rank2)
      else
        if input.index("f.", index) == index
          r8 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("f.")
          r8 = nil
        end
        if r8
          r0 = r8
          r0.extend(Rank2)
        else
          if input.index("B", index) == index
            r9 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("B")
            r9 = nil
          end
          if r9
            r0 = r9
            r0.extend(Rank2)
          else
            if input.index("ssp.", index) == index
              r10 = (SyntaxNode).new(input, index...(index + 4))
              @index += 4
            else
              terminal_parse_failure("ssp.")
              r10 = nil
            end
            if r10
              r0 = r10
              r0.extend(Rank2)
            else
              if input.index("mut.", index) == index
                r11 = (SyntaxNode).new(input, index...(index + 4))
                @index += 4
              else
                terminal_parse_failure("mut.")
                r11 = nil
              end
              if r11
                r0 = r11
                r0.extend(Rank2)
              else
                if input.index("pseudovar.", index) == index
                  r12 = (SyntaxNode).new(input, index...(index + 10))
                  @index += 10
                else
                  terminal_parse_failure("pseudovar.")
                  r12 = nil
                end
                if r12
                  r0 = r12
                  r0.extend(Rank2)
                else
                  if input.index("sect.", index) == index
                    r13 = (SyntaxNode).new(input, index...(index + 5))
                    @index += 5
                  else
                    terminal_parse_failure("sect.")
                    r13 = nil
                  end
                  if r13
                    r0 = r13
                    r0.extend(Rank2)
                  else
                    if input.index("ser.", index) == index
                      r14 = (SyntaxNode).new(input, index...(index + 4))
                      @index += 4
                    else
                      terminal_parse_failure("ser.")
                      r14 = nil
                    end
                    if r14
                      r0 = r14
                      r0.extend(Rank2)
                    else
                      if input.index("var.", index) == index
                        r15 = (SyntaxNode).new(input, index...(index + 4))
                        @index += 4
                      else
                        terminal_parse_failure("var.")
                        r15 = nil
                      end
                      if r15
                        r0 = r15
                        r0.extend(Rank2)
                      else
                        if input.index("subvar.", index) == index
                          r16 = (SyntaxNode).new(input, index...(index + 7))
                          @index += 7
                        else
                          terminal_parse_failure("subvar.")
                          r16 = nil
                        end
                        if r16
                          r0 = r16
                          r0.extend(Rank2)
                        else
                          if input.index("[var.]", index) == index
                            r17 = (SyntaxNode).new(input, index...(index + 6))
                            @index += 6
                          else
                            terminal_parse_failure("[var.]")
                            r17 = nil
                          end
                          if r17
                            r0 = r17
                            r0.extend(Rank2)
                          else
                            if input.index("subsp.", index) == index
                              r18 = (SyntaxNode).new(input, index...(index + 6))
                              @index += 6
                            else
                              terminal_parse_failure("subsp.")
                              r18 = nil
                            end
                            if r18
                              r0 = r18
                              r0.extend(Rank2)
                            else
                              if input.index("subf.", index) == index
                                r19 = (SyntaxNode).new(input, index...(index + 5))
                                @index += 5
                              else
                                terminal_parse_failure("subf.")
                                r19 = nil
                              end
                              if r19
                                r0 = r19
                                r0.extend(Rank2)
                              else
                                if input.index("race", index) == index
                                  r20 = (SyntaxNode).new(input, index...(index + 4))
                                  @index += 4
                                else
                                  terminal_parse_failure("race")
                                  r20 = nil
                                end
                                if r20
                                  r0 = r20
                                  r0.extend(Rank2)
                                else
                                  if input.index("α", index) == index
                                    r21 = (SyntaxNode).new(input, index...(index + 2))
                                    @index += 2
                                  else
                                    terminal_parse_failure("α")
                                    r21 = nil
                                  end
                                  if r21
                                    r0 = r21
                                    r0.extend(Rank2)
                                  else
                                    if input.index("ββ", index) == index
                                      r22 = (SyntaxNode).new(input, index...(index + 4))
                                      @index += 4
                                    else
                                      terminal_parse_failure("ββ")
                                      r22 = nil
                                    end
                                    if r22
                                      r0 = r22
                                      r0.extend(Rank2)
                                    else
                                      if input.index("β", index) == index
                                        r23 = (SyntaxNode).new(input, index...(index + 2))
                                        @index += 2
                                      else
                                        terminal_parse_failure("β")
                                        r23 = nil
                                      end
                                      if r23
                                        r0 = r23
                                        r0.extend(Rank2)
                                      else
                                        if input.index("γ", index) == index
                                          r24 = (SyntaxNode).new(input, index...(index + 2))
                                          @index += 2
                                        else
                                          terminal_parse_failure("γ")
                                          r24 = nil
                                        end
                                        if r24
                                          r0 = r24
                                          r0.extend(Rank2)
                                        else
                                          if input.index("δ", index) == index
                                            r25 = (SyntaxNode).new(input, index...(index + 2))
                                            @index += 2
                                          else
                                            terminal_parse_failure("δ")
                                            r25 = nil
                                          end
                                          if r25
                                            r0 = r25
                                            r0.extend(Rank2)
                                          else
                                            if input.index("ε", index) == index
                                              r26 = (SyntaxNode).new(input, index...(index + 2))
                                              @index += 2
                                            else
                                              terminal_parse_failure("ε")
                                              r26 = nil
                                            end
                                            if r26
                                              r0 = r26
                                              r0.extend(Rank2)
                                            else
                                              if input.index("φ", index) == index
                                                r27 = (SyntaxNode).new(input, index...(index + 2))
                                                @index += 2
                                              else
                                                terminal_parse_failure("φ")
                                                r27 = nil
                                              end
                                              if r27
                                                r0 = r27
                                                r0.extend(Rank2)
                                              else
                                                if input.index("θ", index) == index
                                                  r28 = (SyntaxNode).new(input, index...(index + 2))
                                                  @index += 2
                                                else
                                                  terminal_parse_failure("θ")
                                                  r28 = nil
                                                end
                                                if r28
                                                  r0 = r28
                                                  r0.extend(Rank2)
                                                else
                                                  if input.index("μ", index) == index
                                                    r29 = (SyntaxNode).new(input, index...(index + 2))
                                                    @index += 2
                                                  else
                                                    terminal_parse_failure("μ")
                                                    r29 = nil
                                                  end
                                                  if r29
                                                    r0 = r29
                                                    r0.extend(Rank2)
                                                  else
                                                    if input.index("a.", index) == index
                                                      r30 = (SyntaxNode).new(input, index...(index + 2))
                                                      @index += 2
                                                    else
                                                      terminal_parse_failure("a.")
                                                      r30 = nil
                                                    end
                                                    if r30
                                                      r0 = r30
                                                      r0.extend(Rank2)
                                                    else
                                                      if input.index("b.", index) == index
                                                        r31 = (SyntaxNode).new(input, index...(index + 2))
                                                        @index += 2
                                                      else
                                                        terminal_parse_failure("b.")
                                                        r31 = nil
                                                      end
                                                      if r31
                                                        r0 = r31
                                                        r0.extend(Rank2)
                                                      else
                                                        if input.index("c.", index) == index
                                                          r32 = (SyntaxNode).new(input, index...(index + 2))
                                                          @index += 2
                                                        else
                                                          terminal_parse_failure("c.")
                                                          r32 = nil
                                                        end
                                                        if r32
                                                          r0 = r32
                                                          r0.extend(Rank2)
                                                        else
                                                          if input.index("d.", index) == index
                                                            r33 = (SyntaxNode).new(input, index...(index + 2))
                                                            @index += 2
                                                          else
                                                            terminal_parse_failure("d.")
                                                            r33 = nil
                                                          end
                                                          if r33
                                                            r0 = r33
                                                            r0.extend(Rank2)
                                                          else
                                                            if input.index("e.", index) == index
                                                              r34 = (SyntaxNode).new(input, index...(index + 2))
                                                              @index += 2
                                                            else
                                                              terminal_parse_failure("e.")
                                                              r34 = nil
                                                            end
                                                            if r34
                                                              r0 = r34
                                                              r0.extend(Rank2)
                                                            else
                                                              if input.index("g.", index) == index
                                                                r35 = (SyntaxNode).new(input, index...(index + 2))
                                                                @index += 2
                                                              else
                                                                terminal_parse_failure("g.")
                                                                r35 = nil
                                                              end
                                                              if r35
                                                                r0 = r35
                                                                r0.extend(Rank2)
                                                              else
                                                                if input.index("k.", index) == index
                                                                  r36 = (SyntaxNode).new(input, index...(index + 2))
                                                                  @index += 2
                                                                else
                                                                  terminal_parse_failure("k.")
                                                                  r36 = nil
                                                                end
                                                                if r36
                                                                  r0 = r36
                                                                  r0.extend(Rank2)
                                                                else
                                                                  if input.index("****", index) == index
                                                                    r37 = (SyntaxNode).new(input, index...(index + 4))
                                                                    @index += 4
                                                                  else
                                                                    terminal_parse_failure("****")
                                                                    r37 = nil
                                                                  end
                                                                  if r37
                                                                    r0 = r37
                                                                    r0.extend(Rank2)
                                                                  else
                                                                    if input.index("**", index) == index
                                                                      r38 = (SyntaxNode).new(input, index...(index + 2))
                                                                      @index += 2
                                                                    else
                                                                      terminal_parse_failure("**")
                                                                      r38 = nil
                                                                    end
                                                                    if r38
                                                                      r0 = r38
                                                                      r0.extend(Rank2)
                                                                    else
                                                                      if input.index("*", index) == index
                                                                        r39 = (SyntaxNode).new(input, index...(index + 1))
                                                                        @index += 1
                                                                      else
                                                                        terminal_parse_failure("*")
                                                                        r39 = nil
                                                                      end
                                                                      if r39
                                                                        r0 = r39
                                                                        r0.extend(Rank2)
                                                                      else
                                                                        self.index = i0
                                                                        r0 = nil
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

    node_cache[:rank][start_index] = r0

    return r0
  end

  module SpeciesName0
    def hybrid_separator
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def a
      elements[2]
    end

    def space_hard
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module SpeciesName1
    def value
      "× " + a.value + " " + b.value
    end
    def canonical
      a.value + " " + b.value
    end
    def details
      {:genus => a.value, :species => b.value, :cross => 'before'}
    end
  end

  module SpeciesName2
    def hybrid_separator
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def a
      elements[2]
    end
  end

  module SpeciesName3
    def value
      "× " + a.value
    end
    def canonical
      a.value
    end
    def details
      {:uninomial => a.value, :cross => 'before'}
    end
  end

  module SpeciesName4
    def a
      elements[0]
    end

    def space_hard
      elements[1]
    end

    def hybrid_separator
      elements[2]
    end

    def space_hard
      elements[3]
    end

    def b
      elements[4]
    end
  end

  module SpeciesName5
    def value
      a.value + " × " + b.value
    end
    def canonical
      a.value + " " + b.value
    end
    def details
      {:genus => a.value, :species => b.value, :cross => 'inside'}
    end
  end

  module SpeciesName6
    def a
      elements[0]
    end

    def space
      elements[1]
    end

    def b
      elements[2]
    end

    def space
      elements[3]
    end

    def c
      elements[4]
    end
  end

  module SpeciesName7
    def value
      a.value + " " + b.value + " " + c.value
    end
    def canonical
      a.value + " " + c.value
    end
    def details
      {:genus => a.value, :subgenus => b.details, :species => c.value}
    end
  end

  module SpeciesName8
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

  module SpeciesName9
    def value
      a.value + " " + b.value 
    end
    def canonical
      value
    end
    
    def details
      {:genus => a.value, :species => b.value}
    end
  end

  def _nt_species_name
    start_index = index
    if node_cache[:species_name].has_key?(index)
      cached = node_cache[:species_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_hybrid_separator
    s1 << r2
    if r2
      r3 = _nt_space_hard
      s1 << r3
      if r3
        r4 = _nt_cap_latin_word
        s1 << r4
        if r4
          r5 = _nt_space_hard
          s1 << r5
          if r5
            r6 = _nt_latin_word
            s1 << r6
          end
        end
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SpeciesName0)
      r1.extend(SpeciesName1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i7, s7 = index, []
      r8 = _nt_hybrid_separator
      s7 << r8
      if r8
        r9 = _nt_space_hard
        s7 << r9
        if r9
          r10 = _nt_cap_latin_word
          s7 << r10
        end
      end
      if s7.last
        r7 = (SyntaxNode).new(input, i7...index, s7)
        r7.extend(SpeciesName2)
        r7.extend(SpeciesName3)
      else
        self.index = i7
        r7 = nil
      end
      if r7
        r0 = r7
      else
        i11, s11 = index, []
        r12 = _nt_cap_latin_word
        s11 << r12
        if r12
          r13 = _nt_space_hard
          s11 << r13
          if r13
            r14 = _nt_hybrid_separator
            s11 << r14
            if r14
              r15 = _nt_space_hard
              s11 << r15
              if r15
                r16 = _nt_latin_word
                s11 << r16
              end
            end
          end
        end
        if s11.last
          r11 = (SyntaxNode).new(input, i11...index, s11)
          r11.extend(SpeciesName4)
          r11.extend(SpeciesName5)
        else
          self.index = i11
          r11 = nil
        end
        if r11
          r0 = r11
        else
          i17, s17 = index, []
          r18 = _nt_cap_latin_word
          s17 << r18
          if r18
            r19 = _nt_space
            s17 << r19
            if r19
              r20 = _nt_subgenus
              s17 << r20
              if r20
                r21 = _nt_space
                s17 << r21
                if r21
                  r22 = _nt_latin_word
                  s17 << r22
                end
              end
            end
          end
          if s17.last
            r17 = (SyntaxNode).new(input, i17...index, s17)
            r17.extend(SpeciesName6)
            r17.extend(SpeciesName7)
          else
            self.index = i17
            r17 = nil
          end
          if r17
            r0 = r17
          else
            i23, s23 = index, []
            r24 = _nt_cap_latin_word
            s23 << r24
            if r24
              r25 = _nt_space_hard
              s23 << r25
              if r25
                r26 = _nt_latin_word
                s23 << r26
              end
            end
            if s23.last
              r23 = (SyntaxNode).new(input, i23...index, s23)
              r23.extend(SpeciesName8)
              r23.extend(SpeciesName9)
            else
              self.index = i23
              r23 = nil
            end
            if r23
              r0 = r23
            else
              self.index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:species_name][start_index] = r0

    return r0
  end

  module Subgenus0
    def space
      elements[1]
    end

    def a
      elements[2]
    end

    def space
      elements[3]
    end

  end

  module Subgenus1
    def value
      "(" + a.value + ")"
    end
    def details
      a.value
    end
  end

  def _nt_subgenus
    start_index = index
    if node_cache[:subgenus].has_key?(index)
      cached = node_cache[:subgenus][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_space
      s0 << r2
      if r2
        r3 = _nt_cap_latin_word
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            if input.index(")", index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(")")
              r5 = nil
            end
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Subgenus0)
      r0.extend(Subgenus1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:subgenus][start_index] = r0

    return r0
  end

  module LatinWord0
  end

  module LatinWord1
    def value 
      text_value.strip
    end
  end

  def _nt_latin_word
    start_index = index
    if node_cache[:latin_word].has_key?(index)
      cached = node_cache[:latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[a-zë]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[a-z\\-ëüäöï]'), index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      if s2.empty?
        self.index = i2
        r2 = nil
      else
        r2 = SyntaxNode.new(input, i2...index, s2)
      end
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(LatinWord0)
      r0.extend(LatinWord1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:latin_word][start_index] = r0

    return r0
  end

  module CapLatinWord0
  end

  module CapLatinWord1
    def value
      text_value.strip
    end
    
    def canonical 
      text_value.strip
    end
    
    def details 
      {:uninomial => value}
    end
  end

  def _nt_cap_latin_word
    start_index = index
    if node_cache[:cap_latin_word].has_key?(index)
      cached = node_cache[:cap_latin_word][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[A-Z]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[a-zë]'), index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          if input.index(Regexp.new('[a-z\\-ëüäöï]'), index) == index
            r4 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          self.index = i3
          r3 = nil
        else
          r3 = SyntaxNode.new(input, i3...index, s3)
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(CapLatinWord0)
      r0.extend(CapLatinWord1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:cap_latin_word][start_index] = r0

    return r0
  end

  module HybridSeparator0
    def value
      "x"
    end
  end

  def _nt_hybrid_separator
    start_index = index
    if node_cache[:hybrid_separator].has_key?(index)
      cached = node_cache[:hybrid_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("x", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("x")
      r1 = nil
    end
    if r1
      r0 = r1
      r0.extend(HybridSeparator0)
    else
      if input.index("X", index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("X")
        r2 = nil
      end
      if r2
        r0 = r2
        r0.extend(HybridSeparator0)
      else
        if input.index("×", index) == index
          r3 = (SyntaxNode).new(input, index...(index + 2))
          @index += 2
        else
          terminal_parse_failure("×")
          r3 = nil
        end
        if r3
          r0 = r3
          r0.extend(HybridSeparator0)
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:hybrid_separator][start_index] = r0

    return r0
  end

  module Year0
    def value
      text_value.strip
    end
    def details
      {:year => value}
    end
  end

  def _nt_year
    start_index = index
    if node_cache[:year].has_key?(index)
      cached = node_cache[:year][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(Regexp.new('[0-9]'), index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
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
      r0 = SyntaxNode.new(input, i0...index, s0)
      r0.extend(Year0)
    end

    node_cache[:year][start_index] = r0

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
        r1 = (SyntaxNode).new(input, index...(index + 1))
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
    r0 = SyntaxNode.new(input, i0...index, s0)

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
        r1 = (SyntaxNode).new(input, index...(index + 1))
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
      r0 = SyntaxNode.new(input, i0...index, s0)
    end

    node_cache[:space_hard][start_index] = r0

    return r0
  end

end

class ScientificNameParser < Treetop::Runtime::CompiledParser
  include ScientificName
end
