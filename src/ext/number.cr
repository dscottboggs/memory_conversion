struct ::Number
  {% for pluralized in {true, false} %}
    {% for prefix, scale in MemoryConversion::FACTORS %}
      # Return a `MemoryConversion::Bits` which has this number of {{prefix.id}}bits.
      #
      # ```
      # one_{{prefix.downcase.id}}bit = 1.{{prefix.downcase.id}}bit # => MemoryConversion::Bits(@value={{1 << (scale * 10)}})
      # one_{{prefix.downcase.id}}bit.to_bits # => {{1 << (scale * 10)}}_f64
      # ```
      def {{prefix.downcase.id}}bit{% if pluralized %}s{% end %}
        MemoryConversion::Bits.new initialized: BigFloat.new(self) * (BigInt.new(1) << ({{scale}} * 10))
      end
      # Return a `MemoryConversion::Bytes` which has this number of {{prefix.id}}bytes.
      #
      # ```
      # one_{{prefix.downcase.id}}byte = 1.{{prefix.downcase.id}}byte # => MemoryConversion::Bytes(@value={{1 << (scale * 10)}})
      # one_{{prefix.downcase.id}}byte.to_bytes # => {{1 << (scale * 10)}}_f64
      # ```
      def {{prefix.downcase.id}}byte{% if pluralized %}s{% end %}
        MemoryConversion::Bytes.new initialized: BigFloat.new(self) * (BigInt.new(1) << ({{scale}} * 10))
      end
      # Return a `MemoryConversion::Bytes` which has this number of {{prefix.id}}bytes,
      # as measured by storage manufacturers (i.e. powers of 10).
      #
      # ```
      # one_{{prefix.downcase.id}}byte = 1.{{prefix.downcase.id}}byte # => MemoryConversion::Bytes(@value={{10 ** scale}})
      # one_{{prefix.downcase.id}}byte.to_bytes # => {{10 ** scale}}_f64
      # ```
      def storage_{{prefix.downcase.id}}byte{% if pluralized %}s{% end %}
        MemoryConversion::Bytes.new initialized: BigFloat.new(self) * (BigInt.new(10) ** {{scale}})
      end
    {% end %}
  {% end %}
end
