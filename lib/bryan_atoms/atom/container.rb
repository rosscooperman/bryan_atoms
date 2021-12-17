class VideoMetadata
  module Atom
    class Container < VideoMetadata::Atom::Generic
      attr_reader :metadata

      delegate :atoms, to: :metadata

      def initialize(data)
        super(data)
        @metadata = VideoMetadata.new.tap { |vm| vm << self.data }
      end
    end
  end
end
