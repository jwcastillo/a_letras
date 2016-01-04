require 'a_letras'

RSpec.describe ALetras do
  context 'cuando el numero es 0' do
    it { expect(ALetras.numero(0)).to eq('cero') }
  end
  context 'cuando el numero es mayor de 0' do
    it { expect(ALetras.numero(5)).to eq('cinco') }
    it { expect(ALetras.numero(15)).to eq('quince') }
    it { expect(ALetras.numero(21)).to eq('veintiuno') }
    it { expect(ALetras.numero(119)).to eq('cientodiecinueve') }
    it { expect(ALetras.numero(1001)).to eq('un mil uno') }
    it { expect(ALetras.numero(1_000_000)).to eq('un millon') }
    it { expect(ALetras.numero(2_000_500)).to eq('dos millones quinientos') }
  end
  context 'cuando el numero es un decimal' do
    it { expect(ALetras.numero(5.5)).to eq('cinco punto cincuenta') }
    it { expect(ALetras.numero(900.88)).to eq('novecientos punto ochenta y ocho') }
  end
  context 'cuando el numero es menor de 0' do
    it { expect(ALetras.numero(-1)).to eq('menos uno') }
    it { expect(ALetras.numero(-15)).to eq('menos quince') }
    it { expect(ALetras.numero(-21)).to eq('menos veintiuno') }
    it { expect(ALetras.numero(-119)).to eq('menos cientodiecinueve') }
    it { expect(ALetras.numero(-1001)).to eq('menos un mil uno') }
    it { expect(ALetras.numero(-1_000_000)).to eq('menos un millon') }
    it { expect(ALetras.numero(-2_000_500)).to eq('menos dos millones quinientos') }

    it { expect(ALetras.numero(-900.88)).to eq('menos novecientos punto ochenta y ocho') }
  end
  context 'cuando es el maximo soportado' do
    it { expect(ALetras.numero(999_999_999)).to eq('novecientos noventa y nueve millones novecientos noventa y nueve mil novecientos noventa y nueve') }
    it { expect(ALetras.numero(-999_999_999)).to eq('menos novecientos noventa y nueve millones novecientos noventa y nueve mil novecientos noventa y nueve') }
  end
  context 'cuando supera el maximo' do
    it { expect(ALetras.numero(1_000_000_000)).to raise_error(RuntimeError, 'Rango soportado: [- +]999,999,999') }
  end
end
