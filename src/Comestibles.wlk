class Comida {

	const esCarne
	const calorias

	method esCarne() = esCarne

	method calorias() = calorias

	method esPesado() = calorias > 500

}

class BandejaDeComida {

	const componentes = []

	method componentes() = componentes

	method cantidadDeCalorias() = componentes.sum({ comida => comida.calorias() })

}

