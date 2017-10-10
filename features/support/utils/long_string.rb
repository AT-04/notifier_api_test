# Module to generate long strings
module LongString
  def self.generator(l, n)
    cad = ''
    n.to_i.times do
      cad += l.to_s
    end
    cad
  end
end