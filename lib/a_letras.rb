module ALetras
  @unidades = { 1 => 'uno', 2 => 'dos', 3 => 'tres', 4 => 'cuatro', 5 => 'cinco', 6 => 'seis', 7 => 'siete', 8 => 'ocho', 9 => 'nueve' }
  @decenas = { 1 => 'once', 2 => 'doce', 3 => 'trece', 4 => 'catorce', 5 => 'quince' }
  @decenas0 = { 0 => 'diez', 2 => 'veinte', 3 => 'treinta', 4 => 'cuarenta', 5 => 'cincuenta', 6 => 'sesenta', 7 => 'setenta', 8 => 'ochenta', 9 => 'noventa' }
  @decenasn = { 1 => 'dieci', 2 => 'veinti', 3 => 'trenti', 4 => 'cuarenta y ', 5 => 'cincuenta y ', 6 => 'sesenta y ', 7 => 'setenta y ', 8 => 'ochenta y ', 9 => 'noventa y ' }
  @centenas = { 0 => 'cien', 1 => 'ciento', 2 => 'docientos', 3 => 'trecientos', 4 => 'cuatrocientos', 5 => 'quinientos', 6 => 'seiscientos', 7 => 'setecientos', 8 => 'ochocientos', 9 => 'novecientos' }
  MAXIMO_SOPORTADO = 999_999_999

  class << self
      def unidad(num)
        @unidades[num]
      end

      def decena(num)
        divisor = 10
        dec, uni = num.divmod(divisor)

        case dec
        when 0
          return unidad(uni)
        when 1
          return @decenas0[uni] if uni == 0
          (uni < 6) ? (return @decenas[uni]) : (return @decenasn[dec] + unidad(uni))
        when 2..9
          (uni == 0) ? (return @decenas0[dec]) : (return @decenasn[dec] + unidad(uni))
        end
      end

      def centena(num)
        divisor = 100
        cen, dec = num.divmod(divisor)
        case cen
        when 1
          (dec > 0) ? (return @centenas[cen] + decena(dec)) : (return @centenas[dec])
        when 2..9
          return @centenas[cen] + ' ' + ((decena(dec).nil?) ? '' : decena(dec))
        end
        decena(dec)
      end

      def seccion(num, divisor, str_singular, str_plural)
        cientos, resto = num.divmod(divisor)

        letras = ''
        if cientos > 0
          (cientos > 1) ? (letras = centena(cientos) + ' ' + str_plural) : (letras = str_singular)
        end
        letras += '' if resto > 0
        letras
      end

      def millar(num)
        divisor = 1000
        miles, resto = num.divmod(divisor)
        str_miles = seccion(num, divisor, 'un mil', 'mil')
        str_centenas = centena(resto)
        return str_centenas if str_miles == ''
        str_miles + ' ' + ((str_centenas.nil?) ? '' : str_centenas)
      end

      def millon(num)
        divisor = 1_000_000
        millones, resto = num.divmod(divisor)
        str_millones = seccion(num, divisor, 'un millon', 'millones')
        str_miles = millar(resto)
        return str_miles if str_millones == ''
        str_millones + ' ' + ((str_miles.nil?) ? '' : str_miles)
      end
  end

  def self.numero(num)
    # num = num.to_i
    return 'menos ' + numero(num.abs).to_s if num.to_i < 0
    return 'cero' if num == 0
    decimal = ((num.abs - num.to_i.abs) * 100).round
    decimales = num.is_a?(Float) ? " punto #{numero(decimal)}" : ''
    fail 'Rango soportado: [- +]999,999,999' if num.to_i > MAXIMO_SOPORTADO
    case num.to_i.to_s.length
    when 1..2 then   decena(num.to_i)
    when 3 then      centena(num.to_i)
    when 4..6 then   millar(num.to_i)
    when 7..9 then   millon(num.to_i)
    end.tr('_', ' ').squeeze(' ').strip.gsub('uno mil', 'un mil') + decimales
  end
end
