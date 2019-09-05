struct MemoryConversion::Bits
  def initialize(@value : Float64); end

  forward_missing_to @value

  {% for prefix, scale in MemoryConversion::FACTORS %}
    def to_{{prefix.id}}bits : Float
      self / (1 << {{scale}})
    end
    def to_{{prefix.id}}bytes : Float
      to_{{prefix.id}}bits / 8
    end
    def to_{{prefix.id}}_s
      "#{to_{{prefix.id}}bits}{{prefix.capitalize.id}}bits"
    end
    {% end %}

  def to_s(scale : Symbol)
    {% begin %}
      case scale
        {% for prefix, scale in MemoryConversion::FACTORS %}
        when {{prefix.symbolize}} then to_{{prefix.id}}bits_s
        {% end %}
      else raise "Invalid scale #{scale}"
      end
    {% end %}
  end
end
