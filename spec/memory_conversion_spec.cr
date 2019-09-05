require "./spec_helper"

describe MemoryConversion do
  # TODO: Write tests

  it "works" do
    1.kilobyte.to_bytes.should eq 1024
    1.megabyte.to_kilobytes.should eq 1024
    1.byte.to_bits.should eq 8
  end
end
