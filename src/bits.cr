require "./memory_conversion"

struct MemoryConversion::Bits
  @value : BigFloat

  def initialize(value)
    @value = BigFloat.new value
  end

  forward_missing_to @value

  {% for prefix, scale in MemoryConversion::FACTORS %}
    # Convert this number of bits to the equivalent number of
    # {{prefix.id}}bits
    def to_{{prefix.downcase.id}}bits : BigFloat
      self / (BigInt.new(1) << {{scale}})
    end

    # Convert this number of bits to the equivalent number of
    # {{prefix.id}}bytes
    def to_{{prefix.downcase.id}}bytes : BigFloat
      to_{{prefix.downcase.id}}bits / 8
    end
    def to_storage_{{prefix.downcase.id}}bytes : BigFloat
      to_storage_{{prefix.downcase.id}}bits / 8
    end
    # Convert this number of bits to the equivalent number of
    # {{prefix.id}}bits. This uses the metric used by storage manufacturers
    # to inflate their capacity values, by using powers of 10 instead of powers
    # of two.
    def to_storage_{{prefix.downcase.id}}bits : BigFloat
      self / (BigInt.new(10) ** {{scale}})
    end
    # Convert to storage bits and then divide by 8.
    def to_storage_{{prefix.downcase.id}}bytes : BigFloat
      to_storage_{{prefix.downcase.id}}bits / 8
    end
    # Produce a string representing this bit value like `"## {{prefix.id}}bits"`.
    def to_{{prefix.downcase.id}}bit_s
      "#{to_{{prefix.downcase.id}}bits} {{prefix.capitalize.id}}bits"
    end
    # Produce a string representing this bit value like `"##{{prefix[0..0].id}}b"`.
    def to_{{prefix[0..0].downcase.id}}b_s
      "#{to_{{prefix.downcase.id}}bits}{{prefix[0..0].id}}b"
    end
  {% end %}

  def to_s(scale : Symbol)
    {% begin %}
      case scale
        {% for prefix, scale in MemoryConversion::FACTORS %}
        when {{prefix.symbolize}} then to_{{prefix.downcase.id}}bits_s
        {% end %}
      else raise "Invalid scale #{scale}"
      end
    {% end %}
  end
end
