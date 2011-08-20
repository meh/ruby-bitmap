#--
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#  Copyleft meh. [http://meh.paranoid.pk | meh@paranoici.org]
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Bitmap < Hash
  class Value
    attr_reader :bitmap

    def initialize (bitmap, value, names)
      @bitmap = bitmap
      @value  = value.to_i
      @names  = names
    end

    def has? (name)
      @names.member?(name)
    end

    def to_a
      @names
    end

    def + (*what)
      bitmap[*(@names + what.flatten.compact)]
    end

    def - (*what)
      bitmap[*(@names - what.flatten.compact)]
    end

    def to_i
      @value
    end

    def to_s
      to_a.join '|'
    end
  end

  def initialize (data)
    merge!(data)
    freeze
  end

  def [] (*args)
    args.flatten!
    args.compact!

    if args.length == 1 && args.first.is_a?(Integer)
      Value.new(self, args.first, args.first.to_s(2).reverse.chars.each_with_index.map {|bit, index|
        next if bit.to_i.zero?

        key("#{bit}#{'0' * index}".to_i(2)) or raise ArgumentError, "unknown bit at #{index}"
      }.compact)
    else
      Value.new(self, args.map {|arg|
        super(arg) or super(arg.to_s.to_sym) or raise ArgumentError, "unknown symbol #{arg}"
      }.inject {|a, b|
        a | b
      }, args)
    end
  end

  def all
    Value.new(self, values.inject {|a, b|
      a | b
    }, keys)
  end
end
