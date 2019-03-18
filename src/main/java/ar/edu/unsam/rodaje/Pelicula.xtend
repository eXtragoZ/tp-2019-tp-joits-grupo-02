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
		this.precioBase = 30.00
	}
	
	new(int anioRodaje, String titulo, float puntaje, String genero){
		super(titulo, puntaje, genero)
		this.anioRodaje = anioRodaje
		this.precioBase = 30.00
	}
	
	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
	
	override getPrecioEntrada() {
		this.precioBase
	}
}