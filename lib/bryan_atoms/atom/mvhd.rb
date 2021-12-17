class VideoMetadata
  module Atom
    class Mvhd < VideoMetadata::Atom::Generic
      attr_reader :version

      EPOCH_OFFSET = 2_082_844_800

      def initialize(data)
        super(data)
        @version, @ctime, @mtime, @time_scale, @duration = self.data.unpack('CxxxNNNN')
      end

      def created_at
        parse_time(@ctime)
      end

      def updated_at
        parse_time(@mtime)
      end

      def duration
        @duration.to_f / @time_scale
      end

      private

      def parse_time(time)
        Time.at(time - EPOCH_OFFSET)
      end
    end
  end
end
