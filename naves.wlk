import dependencias.*
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
    velocidad = (cuantaVel + velocidad).min(100000)
  }
  method desacelerar(cuantaVel) {
    velocidad = (cuantaVel - velocidad).max(0)
  }
  method acercarseUnPocoAlSol() {
    direccionRespectoAlSol = (1 + direccionRespectoAlSol).min()
  }
  method alejarseUnPocoDelSol() {
    direccionRespectoAlSol = (1 - direccionRespectoAlSol).max(-10)
  }
  method cargarCombustible(cantidad) {
    combustibleActual += cantidad
  }
  method descargarCombustible(cantidad) {
    combustibleActual -= cantidad
  }
  method escapar()
  method avisar()
  method tenerPocaActividad() {
    return self.estaTranquila()
  }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }
  method estaRelajado() = self.estaTranquila() && self.tenerPocaActividad()

  method direccionRespectoAlSol() = direccionRespectoAlSol
  method velocidad() = velocidad
  method combustible() = combustibleActual

  method estaTranquila() = self.combustible() >= 4000 && self.velocidad() < 12000
}

class NaveBaliza inherits Nave {
  var colorDeBalizaActual = "rojo"
  const coloresUtilizados = []

  method cambiarColorDeBaliza(colorNuevo){
    colorDeBalizaActual = colorNuevo
    coloresUtilizados.add(colorNuevo)
  }

  override method prepararViaje() {
    super();
    self.cambiarColorDeBaliza("verde")
    self.orbitar()
  }
  override method escapar(){
    self.acercarse()
  }
  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
  override method tenerPocaActividad() {
    return super() && coloresUtilizados.size() == 0
  }

  override method estaTranquila() = super() && self.colorDeBalizaActual() != "rojo"
  method colorDeBalizaActual() = colorDeBalizaActual
}
class NaveDePasajeros inherits Nave {
  var cantidadDePasajerosActual
  var racionesDeComida = 0
  var cantidadDeBebida = 0
  const racionesServidas = []

  method cargarComida(cantidad) {
    racionesDeComida += cantidad
  }
  method cargarBebida(cantidad) {
    cantidadDeBebida += cantidad
  }
  method servirComida(cantidad){
    racionesDeComida = (racionesDeComida - cantidad).max(0)
    racionesServidas.add(cantidad)
  }
  method servirBebida(cantidad){
    cantidadDeBebida = (cantidadDeBebida - cantidad).max(0)
  }
  method cargarPasajeros(cantidad) {
    cantidadDePasajerosActual = (cantidad + cantidadDePasajerosActual).min(1000)
  }
  method descargarPasajeros(cantidad) {
    cantidadDePasajerosActual -= (cantidad - cantidadDePasajerosActual).max(0)
  }

  override method escapar(){
    self.acelerar(self.velocidad() * 2)
  }
  override method avisar(){
    self.servirComida(cantidadDePasajerosActual)
    self.servirBebida(cantidadDePasajerosActual * 2)
  }
  override method prepararViaje() {
    super();
    self.cargarComida(4 * cantidadDePasajerosActual)
    self.cargarBebida(6 * cantidadDePasajerosActual)
    self.acercarseUnPocoAlSol()
  }
  override method tenerPocaActividad() {
    return super() && racionesServidas.count() < 50
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
  method estaInvisible() = visibilidadActual.estaInvisible()
  method desplegarMisiles() {
    estadoDeMisiles = misilesDesplegados
  }
  method replegarMisiles() {
    estadoDeMisiles = misilesReplegados
  }
  method misilesDesplegados() = estadoDeMisiles.estaDesplegado()
  method emitirMensaje(mensaje){
    bitacora.add(mensaje)
  }
  method mensajesEmitidos() = bitacora
  method primerMensajeEmitido() = bitacora.first()
  method ultimoMensajeemitido() = bitacora.last()
  method esEscueta() = bitacora.all({b => b.length() < 30})

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar(){
    self.emitirMensaje("Amenaza recibida")
  }
  override method prepararViaje() {
    super();
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }
  override method estaTranquila() = super() && self.misilesDesplegados()
}
class NaveHospital inherits NaveDePasajeros{
  const quirofanos = new Quirofano(cantidadDeQuirofanos = 30)
  
  method quirofanosPreparados() = quirofanos.hayQuirofanosPreparados()
  override method estaTranquila() = super() && not quirofanos.hayQuirofanosPreparados()
  override method recibirAmenaza(){
    super();
    quirofanos.prepararQuirofano(quirofanos.cantidadDeQuirofanos())
  }
}
class NaveCombateSigilosa inherits NaveDeCombate {
  override method estaTranquila() = super() && not self.estaInvisible() 
  override method recibirAmenaza(){
    super();
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}