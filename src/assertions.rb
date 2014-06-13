
class AssertionError < StandardError
end

module Assertions
  def assert_true(valor_obtenido)
    raise AssertionError.new "#{valor_obtenido} deberia ser verdadero" unless valor_obtenido
  end

  def assert_false(valor_obtenido)
    assert_true !valor_obtenido
  end

  def assert_equals(valor_esperado, valor_obtenido)
    raise AssertionError.new "Se esperaba #{valor_esperado} y se obtuvo #{valor_obtenido}" unless valor_esperado == valor_obtenido
  end
end