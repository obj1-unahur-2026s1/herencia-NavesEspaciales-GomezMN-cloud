class Nave {
  var velocidad
  var direccionRespectoAlSol = self.orbitar()
  var combustibleActual = 100

  method orbitar() {
    direccionRespectoAlSol = 0
  }
  method alejarse() {
    direccionRespectoAlSol = -10
  }
  method acercarse() {
    direccionRespectoAlSol = 10
  }

  method acelerar(cuantaVel) {
    velocidad += cuantaVel.min(100000)
  }
  method desacelerar(cuantaVel) {
    velocidad -= cuantaVel.max(0)
  }
  method acercarseUnPocoAlSol() {
    direccionRespectoAlSol += 1.min()
  }
  method alejarseUnPocoDelSol() {
    direccionRespectoAlSol -= 1.max(-10)
  }
  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  
  method direccionRespectoAlSol() = direccionRespectoAlSol
  method velocidad() = velocidad
  method combustible() = combustibleActual
  method cargarCombustible(cantidad) {
    combustibleActual += cantidad
  }
  method descargarCombustible(cantidad) {
    combustibleActual -= cantidad
  }

}

class NaveBaliza inherits Nave {
  var colorDeBalizaActual = "rojo"

  method cambiarColorDeBaliza(colorNuevo){
    colorDeBalizaActual = colorNuevo
  }
  method colorDeBalizaActual() = colorDeBalizaActual
  override method prepararViaje() {
    super();
    self.cambiarColorDeBaliza("verde")
    self.orbitar()
  }
}
class NaveDePasajeros inherits Nave {
  var cantidadDePasajerosActual
  var racionesDeComida = 0
  var cantidadDeBebida = 0

  method cargarComida(cantidad) {
    racionesDeComida += cantidad
  }
  method cargarBebida(cantidad) {
    cantidadDeBebida += cantidad
  }
  method cargarPasajeros(cantidad) {
    cantidadDePasajerosActual += cantidad.min(1000)
  }
  method descargarPasajeros(cantidad) {
    cantidadDePasajerosActual -= cantidad.max(0)
  }
  override method prepararViaje() {
    super();
    self.cargarComida(4 * cantidadDePasajerosActual)
    self.cargarBebida(6 * cantidadDePasajerosActual)
    self.acercarseUnPocoAlSol()
  }
}
class NaveDeCombate inherits Nave{
  var visibilidadActual = visible
  var estadoDeMisiles = misilesReplegados
  const property bitacora = []

  method ponerseVisible() {
    visibilidadActual = visible
  }
  method ponerseInvisible() {
    visibilidadActual = invisible
  }
  method estaInvisible() = visibilidadActual
  method desplegarMisiles() {
    estadoDeMisiles = misilesDesplegados  
  }
  method replegarMisiles() {
    estadoDeMisiles = misilesReplegados
  }
  method misilesDesplegados() = estadoDeMisiles
  method emitirMensaje(mensaje){
    bitacora.add(mensaje)
  }
  method mensajesEmitidos() = bitacora
  method primerMensajeEmitido() = bitacora.first()
  method ultimoMensajeemitido() = bitacora.last()
  method esEscueta() = bitacora.find({b => not b.length() > 30})

  override method prepararViaje() {
    super();
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }
}
class NaveHospital inherits NaveDePasajeros{

}










object visible {
}
object invisible {
}
object misilesDesplegados {
}
object misilesReplegados {
}