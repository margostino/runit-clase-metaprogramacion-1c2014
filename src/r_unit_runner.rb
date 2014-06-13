require_relative '../src/assertions'

class RUnitRunner

  def initialize(reporter)
    @reporter = reporter
  end

  def agregar_clases(*clases_test)
    clases_test.each { |una_clase|
      agregar_clase(una_clase)
    }
  end

  def agregar_clase(clase_test)
    @clases_test = @clases_test || []
    @clases_test << clase_test
  end

  def ejecutar
    @clases_test.each { |clase_test|
        self.ejecutar_test_clase clase_test
    }
  end

  def tiene_parametros_el_test? clase_test
    clase_test.instance_methods(false).any? { |method| method.to_s=='parametros' }
  end

  def ejecutar_test_clase(clase_test)

    if tiene_parametros_el_test?(clase_test)

      tests_con_params = clase_test.instance_methods(false)
      .find_all { |method| method.to_s.start_with? 'theory_' }

      tests_con_params.each { |test|
        metodo_con_params=[test, 'parametros'.to_sym]
        self.ejecutar_test_metodo metodo_con_params, clase_test
      }

    else

      tests = clase_test.instance_methods(false)
      .find_all { |method| method.to_s.start_with? 'test_' }

      tests.each { |test| self.ejecutar_test_metodo test, clase_test }

    end

  end

  def safe_send(instance, method_name)
    instance.send(method_name) if instance.respond_to? method_name
  end

  def ejecutar_test_metodo(metodo_test, clase_test)
    instancia_test = clase_test.new
    instancia_test.singleton_class.send :include, Assertions
    begin
      safe_send(instancia_test, :before_each)

      if (metodo_test.class==Array)

        parametros = instancia_test.send metodo_test[1]

        instancia_test.singleton_class.send(:define_method, :send){
            |metodo,*parametros|

          #lista_string_de_params = parametros.first.collect.with_index{ |x,i|
          #  "parametros.first["+i.to_s+"]"
          #}
          lista_string_de_params = parametros.first.join(',')

          #lista_string_de_params = lista_string_de_params.join(',')
          execute_super = ['super',':'+metodo.to_s, ',',lista_string_de_params].join(' ')
          eval execute_super
        }

        instancia_test.send metodo_test[0], parametros
      else
        instancia_test.send metodo_test
      end

      safe_send(instancia_test, :after_each)
      @reporter.agregar_exito(clase_test, metodo_test)
    rescue AssertionError => assertion_error
      @reporter.agregar_fallo(clase_test, metodo_test, assertion_error)
    rescue StandardError => error
      @reporter.agregar_error(clase_test, metodo_test, error)
    end
  end
end