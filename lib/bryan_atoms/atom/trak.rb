class VideoMetadata
  module Atom
    class Trak < VideoMetadata::Atom::Container
      def width
        tkhd_atom&.width || 0
      end

      def height
        tkhd_atom&.height || 0
      end

      private

      def tkhd_atom
        @tkhd_atom ||= atoms.find { |a| a.type == 'tkhd' }
      end
    end
  end
end
