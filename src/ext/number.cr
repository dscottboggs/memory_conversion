struct ::Number
  {% for pluralized in {true, false} %}
  {% for prefix, scale in MemoryConversion::FACTORS %}
    # Return a MemoryConversion::Bits which has this number of {{prefix.id}}bits.
    #
    # ```
    # one_{{prefix.id}}bit = 1.{{prefix.id}}bit # => MemoryConversion::Bits(@value={{1 << (scale * 10)}})
    # one_{{prefix.id}}bit.to_bits # => {{1 << (scale * 10)}}_f64
    # ```
    def {{prefix.id}}bit{% if pluralized %}s{% end %}
      MemoryConversion::Bits.new self * (1 << ({{scale}} * 10))
    end
    # Return a MemoryConversion::Bytes which has this number of {{prefix.id}}bytes.
    # 
    # ```
    # one_{{prefix.id}}byte = 1.{{prefix.id}}byte # => MemoryConversion::Bytes(@value={{1 << (scale * 10)}})
    # one_{{prefix.id}}byte.to_bytes # => {{1 << (scale * 10)}}_f64
    # ```
    def {{prefix.id}}byte{% if pluralized %}s{% end %}
      MemoryConversion::Bytes.new self * (1 << ({{scale}} * 10))
    end
    # Return a MemoryConversion::Bytes which has this number of {{prefix.id}}bytes,
    # as measured by storage manufacturers (i.e. powers of 10).
    # 
    # ```
    # one_{{prefix.id}}byte = 1.{{prefix.id}}byte # => MemoryConversion::Bytes(@value={{10 ** scale}})
    # one_{{prefix.id}}byte.to_bytes # => {{10 ** scale}}_f64
    # ```
    def storage_{{prefix.id}}byte{% if pluralized %}s{% end %}
      MemoryConversion::Bytes.new self * (10 ** {{scale}})
    end
    {% end %}
  {% end %}
end
