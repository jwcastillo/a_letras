module ALetras
  @unidades = { 1 => 'uno', 2 => 'dos', 3 => 'tres', 4 => 'cuatro', 5 => 'cinco', 6 => 'seis', 7 => 'siete', 8 => 'ocho', 9 => 'nueve' }

  def unidad(num)
    @unidades[num]
  end

  def numero(num)
    num = num.to_i
    unidad(num)
    end
end
