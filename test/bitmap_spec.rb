#! /usr/bin/env ruby
require 'rubygems'
require 'bitmap'

describe Bitmap do
  let(:bits) {
    Bitmap.new(
      :OMG => 0x01,
      :WAT => 0x02,
      :LOL => 0x04
    )
  }

  it 'creates and handles bits correctly' do
    bits[:WAT, :OMG].to_i.should == 0x03
  end

  describe '#+' do
    it 'works correctly' do
      (bits[:WAT] + :OMG).to_i.should == 0x03
    end
  end

  describe '#-' do
    it 'works correctly' do
      (bits.all - :LOL).to_i.should == 0x03
    end
  end

  describe '#has?' do
    it 'works correctly' do
      bits.all.has?(bits[:OMG, :WAT]).should == true
    end
  end
end
