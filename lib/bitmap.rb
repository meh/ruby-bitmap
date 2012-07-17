#--
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Bitmap
	class Value
		attr_reader :bitmap

		def initialize (bitmap, value, names)
			@bitmap = bitmap
			@value  = value.to_i
			@names  = names
		end

		def has? (mask)
			if mask.is_a?(Value)
				(@names.to_a & mask.to_a) == mask.to_a
			else
				@names.member?(mask.to_s.to_sym)
			end
		end

		def to_a
			@names
		end

		def + (*what)
			bitmap[*(@names + what.flatten.map {|piece|
				piece.to_a rescue piece
			}).flatten.compact]
		end

		def - (*what)
			bitmap[*(@names - what.flatten.map {|piece|
				piece.to_a rescue piece
			}).flatten.compact]
		end

		def to_i
			@value
		end

		def to_s
			to_a.join '|'
		end
	end

	def initialize (data)
		if data.first.first.is_a? Integer
			data = Hash[data.map(&:reverse)]
		end

		@bits = data
		@bits.freeze
	end

	def [] (*args)
		args.flatten!
		args.compact!

		if args.length == 1 && args.first.is_a?(Integer)
			Value.new(self, args.first, args.first.to_s(2).reverse.chars.each_with_index.map {|bit, index|
				next if bit.to_i.zero?

				@bits.key("#{bit}#{'0' * index}".to_i(2)) or raise ArgumentError, "unknown bit at #{index}"
			}.compact)
		else
			Value.new(self, args.map {|arg|
				@bits[arg] or @bits[arg.to_s.to_sym] or raise ArgumentError, "unknown symbol #{arg}"
			}.inject {|a, b|
				a | b
			}, args)
		end
	end

	def all
		Value.new(self, @bits.values.inject {|a, b|
			a | b
		}, @bits.keys)
	end

	def inspect
		"#<#{self.class.name}: #{@bits.map { |name, bit| "#{bit.to_s(16)}=#{name}" }.join ' '}>"
	end
end
