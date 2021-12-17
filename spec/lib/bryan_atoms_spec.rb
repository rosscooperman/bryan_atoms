require 'spec_helper'
require 'bryan_atoms'

RSpec.describe BryanAtoms do
  let(:metadata) { described_class.new }
  let(:video) { File.open(Rails.root.join('spec', 'fixtures', 'video.mp4')) }

  it 'defaults duration to 0' do
    expect(metadata.duration).to eq(0)
  end

  it 'defaults width to 0' do
    expect(metadata.width).to eq(0)
  end

  it 'defaults height to 0' do
    expect(metadata.height).to eq(0)
  end

  describe '<<' do
    subject(:atoms) { metadata.atoms }

    let(:bytes) { 32 }

    before { metadata << video.read(bytes) }

    it 'begins reading atoms' do
      expect(atoms.count).to eq(1)
    end

    it 'produces Generic atoms by default' do
      expect(atoms.first).to be_a(VideoMetadata::Atom::Generic)
    end

    context 'when there are not enough bytes remaining to read an atom' do
      let(:bytes) { 31 }

      it 'does not read any atoms' do
        expect(atoms.count).to eq(0)
      end
    end

    context 'when reading the moov atom' do
      let(:bytes) { 91_660 }

      it 'properly returns duration of the video' do
        expect(metadata.duration.round(2)).to eq(41.03)
      end

      it 'properly returns the width of the video' do
        expect(metadata.width).to eq(640)
      end

      it 'properly returns the height of the video' do
        expect(metadata.height).to eq(400)
      end

      it 'does not add more bytes to the buffer once the moov atom has been read' do
        expect { metadata << 'some more data' }.not_to change { metadata.buffer.length }
      end
    end

    context 'when reading past the moov atom' do
      let(:bytes) { video.size }

      it 'does not parse atoms once it finds the moov atom' do
        expect(metadata.atoms.count).to eq(2)
      end
    end
  end

  describe 'atom sizes of 0' do
    subject(:atom) { metadata.atoms.first }

    let(:video) { StringIO.new([0, 'skip'].pack('Na4')) }

    before { metadata << video.read }

    it 'does not attempt to parse forever' do
      Timeout.timeout(0.1) do
        expect { atom }.not_to raise_error
      end
    end

    context 'when metadata parser is marked as finished reading' do
      before { metadata.finish! }

      it 'does parse the 0 size atom' do
        expect(atom.type).to eq('skip')
      end
    end
  end
end
