package ar.edu.unsam.funcion

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.rodaje.Rodaje

@Accessors
@Observable
class Funcion {
	val formatterDate = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	val formatterTime = DateTimeFormatter.ofPattern("HH:mm")
	val formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
	
	LocalDateTime fechaHora
	String nombreSala
	Rodaje rodaje
	
	new() {
		super()
	}

	new(Rodaje rodaje, LocalDateTime fechaHora, String nombreSala) {
		this.rodaje = rodaje
		this.fechaHora = fechaHora
		this.nombreSala = nombreSala
	}
	
	def getFecha() {
		formatterDate.format(fechaHora)
	}
	
	def getHora() {
		formatterTime.format(fechaHora)
	}
	
	def getFechaHora() {
		formatterDateTime.format(fechaHora)
	}
	
	def getDia() {
		this.fechaHora.dayOfWeek.value
	}
	
	def double getPrecioPorDiaDeFuncion() {
		if(dia > 5) 120.00 else this.getPrecioSiNoEsFinde()
	}
	
	def double getPrecioSiNoEsFinde() {
		if(dia == 3) 50.00 else 80.00
	}
	
	def getPrecio() {
		rodaje.precioEntrada + this.precioPorDiaDeFuncion
	}
	
}
