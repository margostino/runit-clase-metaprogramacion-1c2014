require 'rspec'
require '../fixture/un_test'
require '../fixture/un_test_con_error'
require '../src/r_unit_runner'
require_relative 'test_reporters'

describe 'resultados_de_test' do

  def run_and_report(test_class)
    reporter = ReporteEnMemoria.new
    runit = RUnitRunner.new reporter
    runit.ejecutar_test_clase test_class
    reporter
  end

  it 'si le proveo una clase que tiene un test que pasa y uno que falla puedo distinguirlos' do
    reporter = run_and_report(UnTest)
    reporter.paso?(UnTest, :test_que_funciona).should==true
    reporter.paso?(UnTest, :test_que_falla).should==false
    reporter.fallo?(UnTest, :test_que_falla).should==true
    reporter.fallo?(UnTest, :test_que_funciona).should==false
  end

  it 'si le proveo una clase con un test erroneo deberia estar en el reporte' do
    reporter = run_and_report(UnTestConError)
    reporter.fallo_con_error?(UnTestConError, :test_falla_con_error, ZeroDivisionError).should==true
    reporter.fallo_con_error?(UnTestConError, :test_falla_con_error, NoMethodError).should==false
  end


end