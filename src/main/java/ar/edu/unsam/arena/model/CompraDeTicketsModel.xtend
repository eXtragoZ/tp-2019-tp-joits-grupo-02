package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import ar.edu.unsam.domain.repos.RepoPeliculasMongoDB
import ar.edu.unsam.domain.repos.RepoUsuarios
import ar.edu.unsam.domain.usuario.Usuario
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.ArrayList
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
	List<Entrada> carrito
	Funcion funcionCarritoSeleccionada
	String mensajeError = ""
	List<Pelicula> peliculas = new ArrayList

	new(Usuario usuario) {
		this.usuario = RepoUsuarios.instance.searchById(usuario.id)
		this.carrito = newArrayList
		this.peliculas = repoPeliculas.allInstances
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "peliculas")
	}

	def List <Pelicula> getPeliculas() {
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
		carrito.add(this.getNewEntrada)
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
	}

	def sacarDelCarrito() {
		carrito.remove(funcionCarritoSeleccionada)
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "carrito")
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
		ObservableUtils.firePropertyChanged(this, "totalPrecioCarrito")
	}

	def limpiarCarrito() {
		carrito.clear
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "carrito")
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
		ObservableUtils.firePropertyChanged(this, "totalPrecioCarrito")
	}

	def comprar() {
		if(this.totalPrecioCarrito > usuario.saldo) throw new UserException(
			"ERROR no tiene saldo para realizar la compra")
		carrito.forEach[funcion|usuario.comprarEntrada(funcion)]
		limpiarCarrito
	}

	@Dependencies("peliculaSeleccionado", "funcionSeleccionada")
	def getValidarFuncion() {
		peliculaSeleccionado !== null && funcionSeleccionada !== null
	}

	def getCantidadItems() {
		carrito.size
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

	def getTotalPrecioCarrito() {
		carrito.fold(0d, [total, entrada|total + entrada.precio])
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
		if(this.carrito.size < 1) throw new UserException("Debe agregar entradas al carrito para avanzar")
	}
}
