struct MemoryConversion::Bytes
  @value : Float64

  def initialize(value)
    @value = value.to_f64
  end

  forward_missing_to @value

  {% for prefix, scale in MemoryConversion::FACTORS %}
      def to_{{prefix.id}}bytes : Float
        pp! self / (1 << ({{scale}} * 10))
      end
      def to_{{prefix.id}}bits : Float
        to_{{prefix.id}}bytes * 8
      end
      def to_{{prefix.id}}_s
        "#{to_{{prefix.id}}bytes}{{prefix.capitalize.id}}bytes"
      end
      {% end %}

  def to_s(scale : Symbol)
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
