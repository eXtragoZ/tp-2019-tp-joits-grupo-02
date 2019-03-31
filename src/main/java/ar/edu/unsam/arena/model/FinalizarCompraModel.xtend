package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.usuario.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils

@Observable
@Accessors
class FinalizarCompraModel {
	
	Usuario usuario
	List<Entrada> carrito
	String mensajeError = ""
	Entrada seleccionado
	
	new(Usuario usuario, List<Entrada> carrito) {
		this.usuario = usuario
		this.carrito = carrito
	}
		
	def sacarDelCarrito() {
		carrito.remove(seleccionado)
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "carrito")
		ObservableUtils.firePropertyChanged(this, "totalPrecioCarrito")
	}
	
	def limpiarCarrito() {
		carrito.clear
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "carrito")
		ObservableUtils.firePropertyChanged(this, "totalPrecioCarrito")
	}
	
	def getTotalPrecioCarrito() {
		carrito.fold(0d, [total, entrada | total + entrada.precio])
	}
	
	@Dependencies("totalPrecioCarrito")
	def getValidarComprar() {
		this.totalPrecioCarrito > 0
	}
	
	def comprar() {
		if(this.totalPrecioCarrito > usuario.saldo)	throw new UserException("ERROR no tiene saldo para realizar la compra")
		carrito.forEach[ entrada | usuario.comprarEntrada(entrada)]
	}
	
}