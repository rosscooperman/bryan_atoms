class VideoMetadata
  module Atom
    class Tkhd < VideoMetadata::Atom::Generic
      attr_reader :width, :height

      def initialize(data)
        super(data)
        @width, @height = self.data.unpack("#{'x' * 76}nxxn")
      end
    end
  end
end
