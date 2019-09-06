require "./memory_conversion"

struct MemoryConversion::Bytes
  @value : Float64

  def initialize(value)
    @value = value.to_f64
  end

  forward_missing_to @value

  {% for prefix, scale in MemoryConversion::FACTORS %}
    # Convert this number of bytes to the equivalent number of
    # {{prefix.id}}bytes
    def to_{{prefix.id}}bytes : Float64
      self / (1 << ({{scale}} * 10))
    end
    # Convert this number of bytes to the equivalent number of
    # {{prefix.id}}bits
    def to_{{prefix.id}}bits : Float64
      to_{{prefix.id}}bytes * 8
    end
    # Convert this number of bytes to the equivalent number of
    # {{prefix.id}}bytes. This uses the metric used by storage manufacturers
    # to inflate their capacity values, by using powers of 10 instead of powers
    # of two.
    def to_storage_{{prefix.id}}bytes : Float64
      self / (10 ** {{scale}})
    end
    # Convert to storage bytes and then multiply by 8.
    def to_storage_{{prefix.id}}bits : Float64
      to_storage_{{prefix.id}}bytes * 8
    end
    # Produce a string representing this byte value as {{prefix.id}}bytes.
    def to_{{prefix.id}}byte_s
      "#{to_{{prefix.id}}bytes} {{prefix.capitalize.id}}bytes"
    end
    # Produce a string representing this byte value as {{prefix[0..0].id}}B.
    def to_{{prefix[0..0].downcase.id}}b_s
      "#{to_{{prefix.id}}bytes}{{prefix[0..0].id}}B"
    end
  {% end %}

  def to_s(scale : Symbol = :"")
    {% begin %}
        case scale
          {% for prefix, scale in MemoryConversion::FACTORS %}
          when {{prefix.symbolize}} then to_{{prefix.id}}bytes_s
          {% end %}
        else raise "Invalid scale #{scale}"
        end
      {% end %}
  end
end
