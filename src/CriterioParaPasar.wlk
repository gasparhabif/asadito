class CriterioParaPasar {

	method queLePasa(quienLoPide, quienLoTiene, elemento)

}

// algunos son sordos, le pasan el primer elemento que tienen a mano
object sordo inherits CriterioParaPasar {

	override method queLePasa(quienLoPide, quienLoTiene, elemento) = quienLoTiene.elementoAMano()

}

// otros le pasan todos los elementos, “así me dejás comer tranquilo”
object pasaTuti inherits CriterioParaPasar {

	override method queLePasa(quienLoPide, quienLoTiene, elemento) = quienLoTiene.elementosCercanos()

}

// otros le piden que cambien la posición en la mesa, “así de paso charlo con otras personas” 
// (ambos intercambian posiciones, A debe ir a la posición de B y viceversa)
object charlatan inherits CriterioParaPasar {

	override method queLePasa(quienLoPide, quienLoTiene, elemento) {
		const posicionA = quienLoPide.posicion()
		const posicionB = quienLoTiene.posicion()
		const elementosA = quienLoPide.elementosCercanos()
		const elementosB = quienLoTiene.elementosCercanos()
		quienLoPide.posicion(posicionB)
		quienLoTiene.posicion(posicionA)
		quienLoPide.elementosCercanos(elementosB)
		quienLoTiene.elementosCercanos(elementosA)
		return []
	}

}

// y finalmente están las personas que le pasan el bendito elemento al otro comensal
object cumplidor inherits CriterioParaPasar {

	override method queLePasa(quienLoPide, quienLoTiene, elemento) = quienLoTiene.elementosCercanos().filter({ cosa => cosa == elemento })

}

