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

	method comer(comida) {
		if (criterioParaComer.puedeComer(comida)) {
			yaComio.add(comida)
		}
	}

	method pedirElemento(quienLoTiene, elemento) {
		if (quienLoTiene.tieneElemento(elemento)) {
			const elementosQuePasa = quienLoTiene.criterioParaPasar().queLePasa(self, quienLoTiene, elemento)
			self.recibirElementos(elementosQuePasa)
			quienLoTiene.darElementos(elementosQuePasa)
		} else {
			self.error("No puede pedir ese elemento a esa persona, ya que no lo tiene.")
		}
	}

	method tieneElemento(elemento) = elementosCercanos.contains(elemento)

	method recibirElementos(elementos) {
		elementosCercanos.addAll(elementos)
	}

	method darElementos(elementos) {
		elementosCercanos.removeAll(elementos)
	}

	method elementoAMano() = [ elementosCercanos.first() ]

}

const facu = new Persona(posicion = game.at(0, 0), criterioParaPasar = sordo, elementosCercanos = [ "sal", "aceite" ], criterioParaComer = vegetariano)

const moni = new Persona(posicion = game.at(0, 1), criterioParaPasar = pasaTuti, elementosCercanos = [ "vinagre", "mayonesa" ], criterioParaComer = alternado)

const osky = new Persona(posicion = game.at(1, 0), criterioParaPasar = cumplidor, elementosCercanos = [ "pan", "cocacola" ], criterioParaComer = dietetico)

const vero = new Persona(posicion = game.at(1, 1), criterioParaPasar = charlatan, elementosCercanos = [ "agua", "pimienta" ], criterioParaComer = vegetariano)

