require 'spec_helper'

RSpec.describe ByranAtoms::Atom::Mvhd do
  subject(:atom) { described_class.new(data) }

  let(:data) { [108, 'mvhd', 3, 3_664_984_582, 3_664_985_000, 3000, 123_100].pack('Na4CxxxNNNN') }

  it 'returns the correct version' do
    expect(atom.version).to eq(3)
  end

  it 'returns the correct created_at' do
    expect(atom.created_at).to eq(Time.parse('2020-02-19 14:16:22 -0500'))
  end

  it 'returns the correct updated_at' do
    expect(atom.updated_at).to eq(Time.parse('2020-02-19 14:23:20 -0500'))
  end

  it 'returns the correct duration' do
    expect(atom.duration.round(2)).to eq(41.03)
  end
end
