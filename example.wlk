class Nave {
  var velocidad
  var direccionRespectoAlSol = self.orbitar()

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
  
  method direccionRespectoAlSol() = direccionRespectoAlSol
  method velocidad() = velocidad

}

