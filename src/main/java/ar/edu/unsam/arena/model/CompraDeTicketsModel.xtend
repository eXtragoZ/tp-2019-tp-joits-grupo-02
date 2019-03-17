package ar.edu.unsam.arena.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.apache.commons.lang.StringUtils
import ar.edu.unsam.rodaje.Pelicula
import java.util.List
import ar.edu.unsam.funcion.Funcion

@Accessors
@Observable
class CompraDeTicketsModel {
	val String usuario
	String busquedaIngresada
	String busquedaActual
	Pelicula peliculaSeleccionada
	Funcion funcionSeleccionada

	new(String usuario) {
		this.usuario = usuario
	}

	def buscar() {
		busquedaActual = busquedaIngresada
	}

	def getPeliculas() {
		val List<Pelicula> peliculas = newArrayList
		if (StringUtils.isBlank(busquedaActual)) {
			peliculas
		} else {
			peliculas.filter[tieneValorBuscado(busquedaActual)].toList
		}

	}

	def getPeliculasRecomendadas() {
		val List<Pelicula> peliculas = newArrayList
		return peliculas
	}
	
	def agregarAlCarrito() {
		
	}
	
	def getValidarFuncion() {
		return funcionSeleccionada !== null
	}
}
