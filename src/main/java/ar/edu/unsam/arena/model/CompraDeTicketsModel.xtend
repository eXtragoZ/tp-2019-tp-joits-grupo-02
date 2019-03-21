package ar.edu.unsam.arena.model

import ar.edu.unsam.funcion.Funcion
import ar.edu.unsam.repos.Repo
import ar.edu.unsam.rodaje.Pelicula
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import ar.edu.unsam.rodaje.Rodaje

@Accessors
@Observable
class CompraDeTicketsModel {
	val String usuario
	String busquedaIngresada
	String busquedaActual
	Pelicula peliculaSeleccionada
	Funcion funcionSeleccionada
	List<Funcion> carrito

	new(String usuario) {
		this.usuario = usuario
		this.carrito = newArrayList
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "peliculas")
	}

	def getPeliculas() {
		if (StringUtils.isBlank(busquedaActual)) {
			repoRodaje.allInstances
		} else {
			repoRodaje.allInstances.filter[tieneValorBuscado(busquedaActual)].toList
		}
	}

	def getPeliculasRecomendadas() {
		val List<Pelicula> peliculas = newArrayList
		return peliculas
	}

	def agregarAlCarrito() {
		carrito.add(funcionSeleccionada)
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada")
	def getValidarFuncion() {
		peliculaSeleccionada !== null && funcionSeleccionada !== null
	}

	def repoRodaje() {
		ApplicationContext.instance.getSingleton(Rodaje) as Repo<Rodaje>
	}
}
