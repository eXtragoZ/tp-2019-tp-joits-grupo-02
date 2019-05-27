package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import ar.edu.unsam.domain.usuario.Usuario
import ar.edu.unsam.repos.CarritoRedis
import ar.edu.unsam.repos.RepoPeliculasMongoDB
import ar.edu.unsam.repos.RepoUsuarios
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils

@Accessors
@Observable
class CompraDeTicketsModel {
	val formatterDate = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	
	Usuario usuario
	String busquedaIngresada
	String busquedaActual
	Pelicula peliculaSeleccionado
	Funcion funcionSeleccionada
	CarritoRedis carritoRedis = CarritoRedis.instance
	Funcion funcionCarritoSeleccionada
	Entrada entradaCarritoSeleccionada
	String mensajeError = ""

	new(Usuario usuario) {
		this.usuario = RepoUsuarios.instance.searchById(usuario.id)
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "peliculas")
	}

	def List<Pelicula> getPeliculas() {
		if (StringUtils.isBlank(busquedaActual)) {
			repoPeliculas.allInstances
		} else {
			repoPeliculas.allInstances.filter[tieneValorBuscado(busquedaActual)].toList
		}
	}

	def getRecomendadas() {
		return repoPeliculas.searchByExample(new Pelicula)
	}

	def agregarAlCarrito() {
		carritoRedis.agregar(usuario, this.getNewEntrada)
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
	}

	@Dependencies("peliculaSeleccionado", "funcionSeleccionada")
	def getValidarFuncion() {
		peliculaSeleccionado !== null && funcionSeleccionada !== null
	}

	def getCantidadItems() {
		this.carritoRedis.getCantidadItems(usuario)
	}

	def getFechaActual() {
		formatterDate.format(LocalDate.now)
	}

	def getPrecioEntrada() {
		return getNewEntrada().precio
	}

	@Dependencies("funcionSeleccionada")
	def Entrada getNewEntrada() {
		new Entrada(peliculaSeleccionado, funcionSeleccionada)
	}

	def getPeliculaSeleccionado() {
		if(this.peliculaSeleccionado !== null){
			repoPeliculas.searchById(this.peliculaSeleccionado.id)
		}
	}

	def repoPeliculas() {
		RepoPeliculasMongoDB.instance
	}
	
	def getValidarCarrito() {
		if(cantidadItems < 1)
			throw new UserException("Debe agregar entradas al carrito para avanzar")
	}
	
}
