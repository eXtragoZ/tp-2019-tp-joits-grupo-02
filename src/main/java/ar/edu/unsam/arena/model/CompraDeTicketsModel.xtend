package ar.edu.unsam.arena.model

import ar.edu.unsam.usuario.Usuario
import ar.edu.unsam.funcion.Funcion
import ar.edu.unsam.repos.Repo
import ar.edu.unsam.rodaje.Pelicula
import ar.edu.unsam.rodaje.Rodaje
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils

@Accessors
@Observable
class CompraDeTicketsModel {
	Usuario usuario
	String busquedaIngresada
	String busquedaActual
	Rodaje rodajeSeleccionado
	Funcion funcionSeleccionada
	List<Funcion> carrito

	new(Usuario usuario) {
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

	@Dependencies("rodajeSeleccionado", "funcionSeleccionada")
	def getValidarFuncion() {
		rodajeSeleccionado !== null && funcionSeleccionada !== null
	}

	def repoRodaje() {
		ApplicationContext.instance.getSingleton(Rodaje) as Repo<Rodaje>
	}
}
