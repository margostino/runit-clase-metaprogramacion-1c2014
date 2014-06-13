class UnTestConAfterEach

  @@valor = 3

  def test_1
    @@valor += 1
    assert_equals 4, @@valor
  end

  def test_2
    @@valor += 2
    assert_equals 5, @@valor
  end

  def after_each
    @@valor = 3
  end
end