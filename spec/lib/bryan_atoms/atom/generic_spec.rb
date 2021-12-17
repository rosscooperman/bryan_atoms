require 'spec_helper'

RSpec.describe BryanAtoms::Atom::Generic do
  subject(:atom) { described_class.new(data) }

  let(:data) { '' }

  it 'defaults size to 0' do
    expect(atom.size).to eq(0)
  end

  it 'defaults type to an empty string' do
    expect(atom.type).to eq('')
  end

  it 'defaults data to an empty string' do
    expect(atom.data).to eq('')
  end

  context 'when given valid header data' do
    let(:data) { [32, 'ftyp', 'qt  '].pack('Na4a4') }

    it 'returns the correct size' do
      expect(atom.size).to eq(32)
    end

    it 'returns the correct type' do
      expect(atom.type).to eq('ftyp')
    end

    it 'returns the correct value for remaining data' do
      expect(atom.data).to eq('qt  ')
    end
  end

  context 'when using an extended size field' do
    let(:data) { [1, 'skip', 16].pack('Na4Q>') }

    it 'returns the correct size' do
      expect(atom.size).to eq(16)
    end

    it 'returns the correct type' do
      expect(atom.type).to eq('skip')
    end

    it 'returns the correct value for remaining data' do
      expect(atom.data).to eq('')
    end
  end

  describe '.resolve' do
    subject(:atom) { described_class.resolve(data) }

    let(:data) { [32, 'ftyp', 'qt  '].pack('Na4a4') }

    it 'returns a generic atom when the given atom is not resolve-able' do
      expect(atom).to be_a(described_class)
    end

    context 'when data represents an atom that can be resolved' do
      let(:data) { [16, 'moov'].pack('Na4') }

      it 'returns an atom of the resolvable type' do
        expect(atom).to be_a(VideoMetadata::Atom::Moov)
      end
    end
  end
end
