class BooleanReporter

  attr_accessor :resultado

  def initialize
    @resultado = true
  end

  def agregar_fallo(clase, metodo, assertion_error)
    @resultado = false
  end

  def agregar_error(clase, metodo, error)
    @resultado = false
  end


  def agregar_exito(clase, metodo)

  end
end

class ReporteEnMemoria

  def initialize
    @fallos = []
    @exitos = []
    @errores = []
  end

  def agregar_fallo(clase, metodo, assertion_error)
    @fallos << [clase, metodo, assertion_error]
  end

  def agregar_exito(clase, metodo)
    @exitos << [clase, metodo]
  end

  def paso?(clase, metodo)
    @exitos.include? [clase, metodo]
  end

  def fallo?(clase, metodo)
    @fallos.any? { |resultado|
      resultado[0] == clase && resultado[1] == metodo
    }
  end

  def fallo_con_error?(clase, metodo, error)
    @errores.any? { |resultado|
      resultado[0] == clase && resultado[1] == metodo && resultado[2].class == error
    }
  end

  def agregar_error(clase, metodo, error)
    @errores << [clase, metodo, error]
  end

end