package ar.edu.unsam.entrada

import ar.edu.unsam.rodaje.Rodaje
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Entrada {
	
	LocalDateTime fechaHora
	Rodaje rodaje
	
	new(Rodaje rodaje) {
		this.fechaHora = LocalDateTime.now
		this.rodaje = rodaje		
	}
	
	def getTituloRodaje() {
		rodaje.titulo
	}
	
}