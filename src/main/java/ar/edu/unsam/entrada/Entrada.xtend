package ar.edu.unsam.entrada

import ar.edu.unsam.rodaje.Rodaje
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Entrada {
	
	LocalDateTime fechaHora
	Rodaje rodaje
	
	new(Rodaje rodaje) {
		this.rodaje = rodaje		
	}
	
}