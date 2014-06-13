class UnTestSumaConParametros

  def parametros
    Array(1..2)
  end

  def theory_conmutatividad_suma(x, y)
    assert_equals(y + x, x + y)
  end

  def theory_conmutatividad_multiplicacion(x, y)
    assert_equals(y * x, x * y)
  end

end

class OtroTestConParametros

  def parametros
    Array(1..3)
  end

  def theory_conmutatividad_suma(x, y, z)
    assert_equals(y + x + z, z+ x + y)
  end

end