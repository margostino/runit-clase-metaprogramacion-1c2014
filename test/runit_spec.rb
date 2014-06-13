require 'rspec'
require '../src/r_unit_runner'
require_relative 'test_reporters'
require '../fixture/un_test'
require '../fixture/un_test_vacio'
require '../fixture/un_test_con_before_each'
require '../fixture/un_test_con_after_each'
require '../fixture/un_test_con_parametros'

describe 'RUnit' do
  # Helpers para testear RUnit
  def run_and_expect(clase_test, resultado_esperado)
    reporter = BooleanReporter.new
    runit = RUnitRunner.new reporter
    runit.ejecutar_test_clase clase_test
    reporter.resultado.should == resultado_esperado
  end

  def run_all_and_expect(resultado_esperado, *clases_test)
    reporter = BooleanReporter.new
    runit = RUnitRunner.new reporter
    clases_test.each {|una_clase_test| runit.agregar_clase una_clase_test }
    runit.ejecutar
    reporter.resultado.should == resultado_esperado
  end

  it 'si le proveo un test vacio deberia correr bien' do
    run_and_expect UnTestVacio, true
  end

  it 'si le proveo un test que falla deberia fallar' do
    run_and_expect UnTest, false
  end

  it 'si le proveo un test que tiene un before_each lo ejecuta antes de cada test' do
    run_and_expect UnTestConBeforeEach, true
  end

  it 'si le proveo un test que tiene un after_each lo ejecuta despues de cada test' do
    run_and_expect UnTestConAfterEach, true
  end

  it 'si le paso varias clases corre los tests de todas ellas' do
    run_all_and_expect(false, UnTest, UnTestVacio, UnTestConBeforeEach)
  end

  it 'si le proveo un test con parametros deberia aceptarlo' do
    run_and_expect UnTestSumaConParametros, true
  end

  it 'si le proveo un test con mas de 2 parametros parametros deberia aceptarlo' do
    run_and_expect OtroTestConParametros, true
  end

end