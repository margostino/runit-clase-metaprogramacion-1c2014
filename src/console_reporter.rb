class ConsoleReporter

  def agregar_exito(clase, metodo)
    puts "WIN #{clase.name}>>#{metodo}"
  end

  def agregar_fallo(clase, metodo, assertion_error)
    puts "FAIL #{clase.name}>>#{metodo}: #{assertion_error}"
    puts "#{assertion_error.backtrace.join "\n"}"
  end

  def agregar_error(clase, metodo, error)
    puts "ERROR #{clase.name}>>#{metodo}: #{error}"
    puts "#{error.backtrace.join "\n"}"
  end
end