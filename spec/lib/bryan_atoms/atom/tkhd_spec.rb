require 'spec_helper'

RSpec.describe BryanAtoms::Atom::Tkhd do
  subject(:atom) { described_class.new(data) }

  let(:data) { [92, 'tkhd', 640, 480].pack("Na4#{'x' * 76}nxxnxx") }

  it 'returns the correct width' do
    expect(atom.width).to eq(640.0)
  end

  it 'returns the correct height' do
    expect(atom.height).to eq(480.0)
  end
end
