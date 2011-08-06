#! /usr/bin/env ruby
require 'rubygems'
require 'bitmap'

describe Bitmap do
  let(:bits) {
    Bitmap.new(
      :OMG => 0x01,
      :WAT => 0x02
    )
  }

  it 'works correctly' do
    bits[:WAT, :OMG].to_i.should == 0x03
    bits[:WAT, :OMG].to_a.should == [:WAT, :OMG]
  end
end
