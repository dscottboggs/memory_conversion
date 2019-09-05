struct ::Number
  {% for pluralized in {true, false} %}
  {% for prefix, scale in MemoryConversion::FACTORS %}
    def {{prefix.id}}bit{% if pluralized %}s{% end %}
      MemoryConversion::Bits.new self * (1 << ({{scale}} * 10))
    end
    def {{prefix.id}}byte{% if pluralized %}s{% end %}
      MemoryConversion::Bytes.new self * (1 << ({{scale}} * 10))
    end
    {% end %}
  {% end %}
end
