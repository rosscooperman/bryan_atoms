require 'spec_helper'

RSpec.describe BryanAtoms::Atom::Container do
  subject(:atom) { described_class.new(data) }

  let(:data) { [16, 'cont', 8, 'fake'].pack('Na4Na4') }

  it 'parses an array of sub-atoms' do
    expect(atom.atoms.first.type).to eq('fake')
  end
end
