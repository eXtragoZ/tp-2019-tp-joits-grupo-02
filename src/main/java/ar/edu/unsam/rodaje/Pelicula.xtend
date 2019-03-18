package ar.edu.unsam.rodaje

import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Pelicula extends Rodaje {
	
	int anioRodaje
	
	new() {
		super()
	}
	
	new(int anioRodaje, String titulo, float puntaje, String genero){
		super(titulo, puntaje, genero)
		this.anioRodaje = anioRodaje
	}
	
	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
}