package ar.edu.unsam.rodaje

import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Pelicula extends Rodaje {
	
	new() {
		super()
		this.precioBase = 30.00
	}
	
	new(int anio, String titulo, float puntaje, String genero){
		super(titulo, anio, puntaje, genero)
		this.precioBase = 30.00
	}
	
	override tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
	
	override getPrecioEntrada() {
		this.precioBase
	}
}