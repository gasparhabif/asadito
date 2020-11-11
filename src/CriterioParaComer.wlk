class CriterioParaComer {

	method puedeComer(comida)

}

// vegetariano: solo come lo que no sea carne
object vegetariano inherits CriterioParaComer {

	override method puedeComer(comida) = !comida.esCarne()

}

// dietético: come lo que insuma menos de 500 calorías, 
// queremos poder configurarlo para todos los que elijan esta estrategia en base a lo que recomiende la OMS (Organización Mundial de la Salud)
object dietetico inherits CriterioParaComer {

	var property caloriasDeOMS = 500

	override method puedeComer(comida) = comida.calorias() < caloriasDeOMS

}

// alternado: acepta y rechaza alternativamente cada comida
object alternado inherits CriterioParaComer {

	var property aceptoAnterior = false

	override method puedeComer(comida) {
		self.aceptoAnterior(!self.aceptoAnterior())
		return aceptoAnterior
	}

}

// una combinación de condiciones, donde todas deben cumplirse para aceptar la comida
// Combinacion es una clase a diferencia del resto de criterios ya que puede haber muchas combinaciones distintas posibles,
// por lo que cada criteiro deberia ser una instancia distinta
class Combinacion inherits CriterioParaComer {

	const property criterios = #{}

	override method puedeComer(comida) = criterios.all({ criterio => criterio.puedeComer(comida) })

}

