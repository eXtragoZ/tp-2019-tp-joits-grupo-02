package ar.edu.unsam.entrada

import ar.edu.unsam.funcion.Funcion
import ar.edu.unsam.rodaje.Rodaje
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Entrada {
	
	LocalDateTime fechaHora
	Rodaje rodaje
	Funcion funcion
	
	new(Rodaje rodaje) {
		this.fechaHora = LocalDateTime.now
		this.rodaje = rodaje		
	}
	
	new(Rodaje rodaje, Funcion funcion) {
		this.fechaHora = LocalDateTime.now
		this.rodaje = rodaje
		this.funcion = funcion
	}
	
	def getTituloRodaje() {
		rodaje.titulo
	}
	
	def getPrecio() {
		rodaje.precioEntrada + funcion.precio
	}
	
}