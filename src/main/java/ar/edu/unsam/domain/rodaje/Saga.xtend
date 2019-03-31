package ar.edu.unsam.domain.rodaje

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Saga extends Rodaje {

	List<Pelicula> peliculas = newArrayList
	int nivelDeClasico
	val PLUS = 5

	new() {
		super()
		this.precioBase = 10.00
	}

	new(String titulo, int anio, float puntaje, String genero) {
		super(titulo, anio, puntaje, genero)
		this.peliculas = peliculas
		this.precioBase = 10.00
	}

	new(List<Pelicula> peliculas, String titulo, int anio, float puntaje, String genero, int nivelDeClasico) {
		super(titulo, anio, puntaje, genero)
		this.peliculas = peliculas
		this.nivelDeClasico = nivelDeClasico
		this.precioBase = 10.00
	}

	def precioPorFuncion() {
		this.funciones.fold(0.00, [total, funcion|total + funcion.getPrecioPorDiaDeFuncion])
	}

	override getPrecioEntrada() {
		this.precioBase * this.peliculas.size * this.nivelDeClasico
	}

	override tieneValorBuscado(String valorBusqueda) {
		this.peliculas.exists[pelicula|pelicula.tieneValorBuscado(valorBusqueda)]
	}

}
