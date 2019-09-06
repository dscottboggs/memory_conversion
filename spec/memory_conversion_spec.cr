require "./spec_helper"

describe MemoryConversion do
  # TODO: Write tests

  it "works" do
    1.kilobyte.to_bytes.should eq 1024
    1.megabyte.to_kilobytes.should eq 1024
    1.byte.to_bits.should eq 8
    1.exabyte.to_bytes.should eq BigInt.new("1152921504606846976")
    1.kilobyte.to_s.should eq "1024.0 bytes"
    1.kilobyte.to_s(:kilo).should eq "1.0 kilobytes"
    1.kilobyte.to_kilobyte_s.should eq "1.0 kilobytes"
    1.gigabyte.to_megabyte_s.should eq "1024.0 Megabytes"
  end
end
