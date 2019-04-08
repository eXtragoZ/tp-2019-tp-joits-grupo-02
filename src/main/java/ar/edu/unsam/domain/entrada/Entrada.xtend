package ar.edu.unsam.domain.entrada

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.rodaje.Rodaje
import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Accessors
class Entrada {
	
	@Id
	@GeneratedValue
	long id
	
	@Column
	LocalDateTime fechaHora
	
	@OneToOne(fetch=FetchType.LAZY)
	Rodaje rodaje
	
	@OneToOne(fetch=FetchType.LAZY)
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