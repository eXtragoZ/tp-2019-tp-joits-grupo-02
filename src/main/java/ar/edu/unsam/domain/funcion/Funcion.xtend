package ar.edu.unsam.domain.funcion

import ar.edu.unsam.domain.rodaje.Rodaje
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Funcion {
	
	@Id	@GeneratedValue
	long id
	
	@Column
	LocalDateTime fechaHora
	
	@Column(length=100)
	String nombreSala
	
//	@OneToOne(fetch=FetchType.LAZY)
//	Rodaje rodaje
	
	
	new() {
		super()
	}

	new(Rodaje rodaje, LocalDateTime fechaHora, String nombreSala) {
//		this.rodaje = rodaje
		this.fechaHora = fechaHora
		this.nombreSala = nombreSala
	}
	
	new(LocalDateTime fechaHora, String nombreSala) {
		this.fechaHora = fechaHora
		this.nombreSala = nombreSala
	}
	
	def getFecha() {
		val formatterDate = DateTimeFormatter.ofPattern("dd/MM/yyyy")
		formatterDate.format(fechaHora)
	}
	
	def getHora() {
		val formatterTime = DateTimeFormatter.ofPattern("HH:mm")
		formatterTime.format(fechaHora)
	}
	
	def getFechaHora() {
		val formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
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
//		rodaje.precioEntrada + 
		this.precioPorDiaDeFuncion
	}
	
}
