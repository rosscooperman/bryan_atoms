class BryanAtoms
  class Buffer
    attr_reader :buffer

    def initialize
      @buffer = StringIO.new
    end

    def <<(data)
      buffer.string << data
    end

    def left
      buffer.length - buffer.pos
    end

    def length
      buffer.length
    end

    def peek(count)
      left >= count ? buffer.string[pos, count] : nil
    end

    def pos
      buffer.pos
    end

    def read(count)
      left >= count ? buffer.read(count) : nil
    end
  end
end
