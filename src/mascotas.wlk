/** First Wollok example */
class Club {
	var property duenios=#{}
	method mascotasSeguras() {
		return duenios.map({duenio => duenio.mascotaMasSegura()}).asSet()
	}
	method fanaticos() {
		return duenios.filter({duenio => duenio.fanatico() })
	}
}
class Duenio {
	var property edad
	var property afecto
	var property mascotas = #{}
	
	method fanatico() {
		return mascotas.size() >= 2
	}
	method afecto() {
		return afecto 
	}
	
	method menor() {
		return edad < 18
	}
	
	method feliz() {
		return self.seguro() and self.alegre()
	}
	
	method seguro() {
		return mascotas.any({mascota=> mascota.seguridad(self) > 21}) 
	}
	
	method alegre()
	
	method eficacia()
	
	method entrenar() {
		self.validarEntrenar()
		mascotas.forEach({mascota => mascota.entrenar(self.eficacia())})
	}
	
	method validarEntrenar() {
		if (not self.puedeEntrenar()) {
			self.error("no puede entrenar")
		}
	}
	method puedeEntrenar() {
		return self.eficacia() > 9
	}
	
	method mascotaMasSegura() {
		return mascotas.max({mascota => mascota.seguridad(self)})
	}
	
}


class Sensible inherits Duenio {
	override method alegre() {
		return self.amor() > self.diversion()
	}
	
	method amor() {
		return mascotas.sum({mascota => mascota.amor(self)})
	}

	method diversion() {
		return mascotas.sum({mascota => mascota.diversion(self)})
	}
	
	override method eficacia(){
		return self.afecto()	
	}
	
}

class Hipersensible inherits Sensible {
	override method diversion() {
		return super() / 2
	}	
}

class Calido inherits Duenio {
	
	override method alegre() {
		return self.cantidadAmorosas() >= self.cantidadAlegria()	
	}	
	method cantidadAlegria() {
		return 2
	}
	
	override method eficacia(){
		return 3 * self.cantidadAmorosas()
	}
	
	method cantidadAmorosas() {
		return mascotas.count( {mascota => mascota.amorosa(self)})
	}
	
}

class Intenso inherits Calido {
	override method alegre() {
		return super() and self.mascotaMasSeguraEsAmorosa()
	}
	
	
	method mascotaMasSeguraEsAmorosa() {
		return self.mascotaMasSegura().amorosa(self)
	}
	
	override method cantidadAlegria() {
		return 3
	}
	
	override method puedeEntrenar() {
		return not self.feliz()
	}
	
}

class Mascota {
	
	var property entrenamientos = 0
	
	method amorosa(duenio) {
		return self.amor(duenio) > 30
	}	
	
	method amor(duenoo)
	method diversion(duenio) 
	method seguridad(duenio) 
	
	method entrenar(eficacia) {
		entrenamientos += 1
	}
	
}

class Perro inherits Mascota {
	var property guardia
	
	override method amor(duenio){
		return duenio.afecto() * 2
	}
	
	override method diversion(duenio) {
		return (100 - duenio.edad()) / 2
	}
	
	override method seguridad(duenio) {
		return self.guardia() + if (duenio.menor()) 7 else 0 
	}
	
	override method entrenar(eficacia) {
		super(eficacia)
		guardia = guardia + self.porcentajeGuardia() * eficacia
	}
	
	method porcentajeGuardia() {
		return 0.10
	}
	
}

class Labrador inherits Perro {
	
	override method amor(duenio) {
		return super(duenio) + 5 
	}
	
	override method porcentajeGuardia() {
		return 0.15
	}	
	
	override method seguridad(duenio) {
		return 2 * guardia
	}
}

class Gato inherits Mascota{
	var property porcentajeAmor
	var property seguridad
	
	override method amor(duenio){
		return duenio.afecto() * porcentajeAmor
	}
	
	override method diversion(duenio) {
		return if (duenio.menor()) 20 else 15
	}
	
	override method seguridad(duenio) {
		return seguridad
	}
	
	override method entrenar(eficacia) {
		super(eficacia)
		porcentajeAmor = (porcentajeAmor + if (eficacia < 20) 0.01 else 0.02).min(1) 
	}
	
}

class Canario inherits Mascota {
	override method amor(duenio){
		return 0
	}
	
	override method diversion(duenio) {
		return 5
	}
	
	override method seguridad(duenio) {
		return 0
	}
	
}
