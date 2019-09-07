require "./memory_conversion"

struct MemoryConversion::Bytes
  @value : BigFloat

  def self.new(value)
    new initialized: BigFloat.new value
  end

  # :nodoc:
  def initialize(*, initialized @value : BigFloat); end

  forward_missing_to @value

  {% for prefix, scale in MemoryConversion::FACTORS %}
    # Convert this number of bytes to the equivalent number of
    # {{prefix.id}}bytes
    def to_{{prefix.downcase.id}}bytes : BigFloat
      self / (BigInt.new(1) << ({{scale}} * 10))
    end
    # Convert this number of bytes to the equivalent number of
    # {{prefix.id}}bits
    def to_{{prefix.downcase.id}}bits : BigFloat
      to_{{prefix.downcase.id}}bytes * 8
    end
    # Convert this number of bytes to the equivalent number of
    # {{prefix.id}}bytes. This uses the metric used by storage manufacturers
    # to inflate their capacity values, by using powers of 10 instead of powers
    # of two.
    def to_storage_{{prefix.downcase.id}}bytes : BigFloat
      self / (BigInt.new(10) ** {{scale}})
    end
    # Convert to storage bytes and then multiply by 8.
    def to_storage_{{prefix.downcase.id}}bits : BigFloat
      to_storage_{{prefix.downcase.id}}bytes * 8
    end
    # Produce a string representing this byte value like `"## {{prefix.id}}bytes"`.
    def to_{{prefix.downcase.id}}byte_s
      "#{to_{{prefix.downcase.id}}bytes} {{prefix.id}}bytes"
    end
    # Produce a string representing this byte value like `"##{{prefix[0..0].id}}B"`.
    def to_{{prefix[0..0].downcase.id}}b_s
      "#{to_{{prefix.downcase.id}}bytes}{{prefix[0..0].id}}B"
    end
  {% end %}

  def to_s(scale : Symbol? = nil)
    {% begin %}
        case scale
          {% for prefix, scale in MemoryConversion::FACTORS.reject &.empty? %}
          when {{prefix.id.symbolize}} then to_{{prefix.downcase.id}}byte_s
          {% end %}
        when nil then to_byte_s
        else raise "Invalid scale #{scale}"
        end
      {% end %}
  end
end
