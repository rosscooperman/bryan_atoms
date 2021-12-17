class VideoMetadata
  module Atom
    class Generic
      def self.resolve(data)
        generic = new(data)
        "VideoMetadata::Atom::#{generic.type.capitalize}".constantize.new(data)
      rescue NameError
        generic
      end

      def initialize(data)
        if data.unpack('N')&.first == 1
          @type, @size, @data = data.unpack("xxxxa4Q>a#{data.length - 16}")
        else
          @size, @type, @data = data.unpack("Na4a#{data.length - 8}")
        end
      end

      def size
        @size || 0
      end

      def type
        @type || ''
      end

      def data
        @data || ''
      end
    end
  end
end
