require_relative '../fixture/un_test'
require_relative '../src/r_unit_runner'
require_relative 'test_reporters'

class RUnitTest
  def run_and_report(test_class)
    reporter = ReporteEnMemoria.new
    runit = RUnitRunner.new reporter
    runit.ejecutar_test_clase test_class
    reporter
  end

  def test_runit_distingue_entre_test_que_pasaron_y_fallaron
    reporter = run_and_report(UnTest)
    assert_true reporter.paso?(UnTest, :test_que_funciona)
    assert_true reporter.paso?(UnTest, :test_que_falla)
    assert_true reporter.fallo?(UnTest, :test_que_falla)
    assert_false reporter.fallo?(UnTest, :test_que_funciona)
  end
end