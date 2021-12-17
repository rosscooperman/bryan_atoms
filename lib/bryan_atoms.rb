require 'bryan_atoms/buffer'

class BryanAtoms
  attr_reader :buffer, :atoms

  def initialize
    @buffer = BryanAtoms::Buffer.new
    @atoms = []
    @finished = false
  end

  def <<(data)
    return if moov_atom.present?
    buffer << data
    read_atoms
  end

  def finish!
    @finished = true
    read_atoms
  end

  def duration
    moov_atom&.mvhd_atom&.duration || 0
  end

  def width
    max_track(:width)
  end

  def height
    max_track(:height)
  end

  def finished?
    @finished
  end

  private

  def read_atoms
    atoms << read_atom while should_read?
  end

  def read_atom
    Atom::Generic.resolve(buffer.read(next_atom_size))
  end

  def should_read?
    moov_atom.nil? && next_atom_size&.positive? && buffer.left >= next_atom_size
  end

  def next_atom_size
    case simple_atom_size
    when 0 then finished? ? buffer.left : 0
    when 1 then extended_atom_size
    else simple_atom_size
    end
  end

  def simple_atom_size
    buffer.peek(4)&.unpack('N')&.first
  end

  def extended_atom_size
    buffer.peek(16)&.unpack('xxxxxxxxQ>')&.first
  end

  def moov_atom
    atoms.find { |a| a.type == 'moov' }
  end

  def max_track(property)
    moov_atom&.trak_atoms&.map(&property)&.max || 0
  end
end
