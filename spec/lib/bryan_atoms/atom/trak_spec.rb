require 'spec_helper'

RSpec.describe BryanAtoms::Atom::Trak do
  subject(:atom) { described_class.new(data) }

  let(:data) { [100, 'trak', 92, 'tkhd', 640, 480].pack("Na4Na4#{'x' * 76}nxxnxx") }

  it 'parses width from its tkhd atom' do
    expect(atom.width).to eq(640)
  end

  it 'parses height from its tkhd atom' do
    expect(atom.height).to eq(480)
  end

  context 'when no tkhd atom is found' do
    let(:data) { [8, 'trak'].pack('Na4') }

    it 'defaults to 0 width' do
      expect(atom.width).to eq(0)
    end

    it 'defaults to 0 height' do
      expect(atom.height).to eq(0)
    end
  end
end
