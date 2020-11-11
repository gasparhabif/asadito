import wollok.game.*
import CriterioParaPasar.*
import CriterioParaComer.*
import Comestibles.*

class Persona {

	var property posicion
	var property elementosCercanos = []
	var property criterioParaPasar
	var property criterioParaComer
	const property yaComio = []

	method pedirElemento(quienLoTiene, elemento) {
		if (quienLoTiene.tieneElemento(elemento)) {
			const elementosQuePasa = quienLoTiene.lePasa(self, elemento)
			self.recibirElementos(elementosQuePasa)
			quienLoTiene.darElementos(elementosQuePasa)
		} else {
			self.error("No puede pedir ese elemento a esa persona, ya que no lo tiene.")
		}
	}

	method lePasa(quienLoQuiere, elemento) = self.criterioParaPasar().queLePasa(quienLoQuiere, self, elemento)

	method tieneElemento(elemento) = elementosCercanos.contains(elemento)

	method recibirElementos(elementos) {
		elementosCercanos.addAll(elementos)
	}

	method darElementos(elementos) {
		elementosCercanos.removeAll(elementos)
	}

	method elementoAMano() = [ elementosCercanos.first() ]

	method comer(comida) {
		if (criterioParaComer.puedeComer(comida)) {
			yaComio.add(comida)
		}
	}

	method estaPipon() = yaComio.any({ comida => comida.esPesada() })

	// Como Riquelme con una Pepsi, pero en los asados
	method estaFeli() = self.comioAlgo()

	method comioAlgo() = yaComio.size() > 0

}

object facu inherits Persona(posicion = game.at(0, 0), criterioParaPasar = sordo, elementosCercanos = [ "sal", "aceite" ], criterioParaComer = vegetariano) {

	method comioCarne() = yaComio.any({ comida => comida.esCarne() })

	override method estaFeli() = super() && self.comioCarne()

}

object moni inherits Persona(posicion = game.at(1, 1), criterioParaPasar = pasaTuti, elementosCercanos = [ "vinagre", "mayonesa" ], criterioParaComer = new Alternado()) {

	method sentadaEnCabecera() = self.posicion() == game.at(1, 1)

	override method estaFeli() = super() && self.sentadaEnCabecera()

}

object osky inherits Persona(posicion = game.at(1, 0), criterioParaPasar = cumplidor, elementosCercanos = [ "pan", "cocacola" ], criterioParaComer = dietetico) {

}

object vero inherits Persona(posicion = game.at(0, 1), criterioParaPasar = charlatan, elementosCercanos = [ "agua", "pimienta" ], criterioParaComer = vegetariano) {

	method tieneMasDeTresElementosCerca() = self.elementosCercanos().size() >= 3

	override method estaFeli() = super() && self.tieneMasDeTresElementosCerca()

}

// Polimorfismo en: estaFeli(), queLePasa() [De CriteroParaPasar] y puedeComer() [De CriterioParaComer]
// Herencia en: 
//	1. facu, moni, osky y vero de Persona
//	2. vegetariano, dietetico y alternado de CriterioParaComer
//  3. sordo, pasaTuti, charlatan, cumplidor de CriterioParaPasar
// Composicion en Combinacion con CriterioParaComer
// La ventaja de haber utilizado estos tres criterios a lo largo del proyecto son: El polimorfismo es la base que hace posible este desarrollo,
// ya que es la forma en que los distintos flujos pueden funcionar con criterios cambiantes y desiguales. 
// Para la herencia, permite agregar criterios de ambos tipos (CriterioParaComer y CriterioParaPasar) sin ningun tipo de dificultades, 
// evitando la repeticion de codigo/logica. Tambien, pueden crearce tantas instancias de Persona como comenzales haya en nuestro asadito, 
// permitiendo una escalabilidad "ilimitada". Por ultimo la Composicion nos permite utilizar multiples criterios para comer sin ser una dificultad 
// mayor ya que cumple con el polimorfismo del resto de criterios, y a su vez permite instanciar tantas combinaciones como se desee.  
