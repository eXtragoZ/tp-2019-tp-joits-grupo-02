package ar.edu.unsam.funcion

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Funcion {
	val formatterDate = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	val formatterTime = DateTimeFormatter.ofPattern("HH:mm")
	
	LocalDateTime fechaHora
	String nombreSala
	
	new() {
		super()
	}

	new(LocalDateTime fechaHora, String nombreSala) {
		this.fechaHora = fechaHora
		this.nombreSala = nombreSala
	}
	
	def getFecha() {
		formatterDate.format(fechaHora)
	}
	
	def getHora() {
		formatterTime.format(fechaHora)
	}
}
