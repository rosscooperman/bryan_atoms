require 'spec_helper'

RSpec.describe BryanAtoms::Atom::Moov do
  subject(:atom) { described_class.new(data) }

  let(:data) { [36, 'moov', 28, 'mvhd', 3, 0, 0, 3000, 123_100].pack('Na4Na4CxxxNNNN') }

  it 'parses an internal mvhd atom' do
    expect(atom.mvhd_atom.duration.round(2)).to eq(41.03)
  end

  it 'returns an empty array of traks' do
    expect(atom.trak_atoms).to be_empty
  end

  context 'when there are trak atoms inside' do
    let(:data) { [16, 'moov', 8, 'trak'].pack('Na4Na4') }

    it 'includes those atoms in its array of traks' do
      expect(atom.trak_atoms.length).to eq(1)
    end
  end
end
