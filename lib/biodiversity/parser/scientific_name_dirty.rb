module ScientificNameDirty
  include Treetop::Runtime

  def root
    @root || :scientific_name
  end

  include ScientificName

  def _nt_scientific_name
    start_index = index
    if node_cache[:scientific_name].has_key?(index)
      cached = node_cache[:scientific_name][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = super

    node_cache[:scientific_name][start_index] = r0

    return r0
  end

  module AuthorsSeparator0
    def apply(a,b)
      a.value + " & " + b.value
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
    if input.index("and", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 3))
      r1.extend(AuthorsSeparator0)
      @index += 3
    else
      terminal_parse_failure("and")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r2 = super
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:authors_separator][start_index] = r0

    return r0
  end

  module Year0
  end

  module Year1
    def value
      text_value
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

    i0 = index
    i1, s1 = index, []
    if input.index(Regexp.new('[0-9]'), index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        if input.index(Regexp.new('[0-9A-Za-z\\?\\-]'), index) == index
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
      s1 << r3
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(Year0)
      r1.extend(Year1)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r5 = super
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:year][start_index] = r0

    return r0
  end

end

class ScientificNameDirtyParser < Treetop::Runtime::CompiledParser
  include ScientificNameDirty
end
