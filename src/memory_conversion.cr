require "big"

module MemoryConversion
  VERSION = "0.1.0"

  FACTORS = ["", "kilo", "Mega", "Giga", "Tera", "Peta", "Exa", "Zetta", "Yotta"] of String
end

require "./bits"
require "./bytes"
require "./ext/number"
