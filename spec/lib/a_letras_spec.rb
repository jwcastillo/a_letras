require 'a_letras'

RSpec.describe ALetras do
  context 'cuando el numero es mayor de 0' do
    it { expect(ALetras.numero(1)).to eq('uno') }
    it { expect(ALetras.numero(5)).to eq('cinco') }
  end
end
