require_relative 'src/r_unit_runner'
require_relative 'src/console_reporter'
require_relative 'test/runit_test'

runit = RUnitRunner.new ConsoleReporter.new
runit.agregar_clases(
  RUnitTest
)

runit.ejecutar


