require 'a_letras'

RSpec.describe ALetras do
  context 'cuando el numero es mayor de 0' do
    it { expect(ALetras.numero(1)).to eq('uno') }
    it { expect(ALetras.numero(5)).to eq('cinco') }
    it { expect(ALetras.numero(15)).to eq('quince') }
    it { expect(ALetras.numero(21)).to eq('veintiuno') }
    it { expect(ALetras.numero(119)).to eq('cientodiecinueve') }
  end
end
