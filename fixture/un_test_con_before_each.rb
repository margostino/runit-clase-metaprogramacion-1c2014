class UnTestConBeforeEach
  def before_each
    @valor = 3
  end

  def test_valida_valor_igual_a_cuatro
    @valor = @valor + 1
    assert_equals 4, @valor
  end

  def test_valida_valor_igual_a_cinco
    @valor = @valor + 2
    assert_equals 5, @valor
  end
end