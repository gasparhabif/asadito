class Comida {

	const esCarne
	const calorias

	method esCarne() = esCarne

	method calorias() = calorias

}

class BandejaDeComida {

	const componentes = []

	method componentes() = componentes

	method cantidadDeCalorias() = componentes.sum({ comida => comida.calorias() })

}

