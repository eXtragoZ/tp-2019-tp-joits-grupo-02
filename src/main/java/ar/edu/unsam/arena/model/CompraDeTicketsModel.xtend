package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.repos.RepoRodajes
import ar.edu.unsam.domain.rodaje.Rodaje
import ar.edu.unsam.domain.usuario.Usuario
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
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
	Rodaje rodajeSeleccionado
	Funcion funcionSeleccionada
	List<Entrada> carrito
	Funcion funcionCarritoSeleccionada
	String mensajeError = ""

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

	def getRecomendadas() {
		return repoRodaje.recomendados
	}

	def agregarAlCarrito() {
		carrito.add(this.getNewEntrada)
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

	@Dependencies("rodajeSeleccionado", "funcionSeleccionada")
	def getValidarFuncion() {
		rodajeSeleccionado !== null && funcionSeleccionada !== null
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
		new Entrada(rodajeSeleccionado, funcionSeleccionada)
	}

	def getTotalPrecioCarrito() {
		carrito.fold(0d, [total, entrada|total + entrada.precio])
	}

//	@Dependencies("rodajeSeleccionado")
	def getRodajeSeleccionado() {
		if(this.rodajeSeleccionado !== null){
			repoRodaje.searchById(this.rodajeSeleccionado.id)
		}
	}

	def repoRodaje() {
		ApplicationContext.instance.getSingleton(Rodaje) as RepoRodajes
	}

}
