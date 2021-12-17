require 'spec_helper'
require 'bryan_atoms/buffer'

RSpec.describe BryanAtoms::Buffer do
  let(:buffer) { described_class.new }

  describe '<<' do
    let(:data) { 'foo' }

    before { buffer << data }

    it 'increases its size by the length of appended data' do
      expect(buffer.length).to eq(3)
    end

    it 'does not change its internal buffer position' do
      expect(buffer.pos).to eq(0)
    end
  end

  describe '#left' do
    subject { buffer.left }

    it 'returns 0 on a new buffer' do
      expect(subject).to eq(0)
    end

    context 'when appending data to the buffer' do
      before { buffer << 'data' }

      it 'increases the left count' do
        expect(subject).to eq(4)
      end

      context 'when then reading some of that data' do
        before { buffer.read(2) }

        it 'decreases the left count by the amount read' do
          expect(subject).to eq(2)
        end
      end
    end
  end

  describe '#read' do
    subject(:read) { buffer.read(count) }

    let(:data) { 'abcdefghijklmnopqrstuvwxyz' }
    let(:count) { 5 }

    before { buffer << data }

    it 'returns the first x bytes of the buffer when there is enough data' do
      expect(read.length).to eq(count)
    end

    context 'when requesting more data than is available' do
      let(:count) { 27 }

      it 'returns nil for the read' do
        expect(read).to be_nil
      end

      it 'does not advance the buffer cursor' do
        expect { read }.not_to change(buffer, :pos)
      end
    end
  end

  describe '#peek' do
    subject(:peek) { buffer.peek(count) }

    let(:data) { 'abcdefghijklmnopqrstuvwxyz' }
    let(:count) { 5 }

    before { buffer << data }

    it 'returns the first x bytes of the buffer when there is enough data' do
      expect(peek.length).to eq(count)
    end

    it 'does not change the buffer position' do
      expect { peek }.not_to change(buffer, :pos)
    end

    context 'when requesting more data than is available' do
      let(:count) { 27 }

      it 'returns nil for the peek' do
        expect(peek).to be_nil
      end
    end

    context 'when some data has already been read' do
      before { buffer.read(count) }

      it 'returns the next set of bytes' do
        expect(peek).to eq('fghij')
      end
    end
  end
end
