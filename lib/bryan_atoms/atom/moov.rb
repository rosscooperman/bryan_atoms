class VideoMetadata
  module Atom
    class Moov < VideoMetadata::Atom::Container
      def mvhd_atom
        atoms.find { |a| a.type == 'mvhd' }
      end

      def trak_atoms
        atoms.select { |a| a.type == 'trak' }
      end
    end
  end
end
