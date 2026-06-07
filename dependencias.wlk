class Quirofano {
  const property cantidadDeQuirofanos
  var cantidadDeQuirofanosUtilizados = 0

  method hayQuirofanosPreparados() = cantidadDeQuirofanosUtilizados < cantidadDeQuirofanos
  method cantidadDeQuirofanosLibres() = cantidadDeQuirofanos - cantidadDeQuirofanosUtilizados
  method prepararQuirofano(cantidad) {
    if (self.hayQuirofanosPreparados() && self.cantidadDeQuirofanosLibres() >= cantidad) {
      cantidadDeQuirofanosUtilizados += cantidad
    }
    else if (self.hayQuirofanosPreparados()) {
      cantidadDeQuirofanosUtilizados = (cantidad + cantidadDeQuirofanosUtilizados).min(cantidadDeQuirofanos)
    }
  }

}









object visible {
    const invisible = false
    method estaInvisible() = invisible
}
object invisible {
    const invisible = true
    method estaInvisible() = invisible
}
object misilesDesplegados {
    const estaDesplegado = true
    method estaDesplegado() = estaDesplegado
}
object misilesReplegados {
    const estaDesplegado = false
    method estaDesplegado() = estaDesplegado
}