package ar.edu.unsam.rodaje

import ar.edu.unsam.funcion.Funcion
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.apache.commons.lang.StringUtils
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Pelicula extends Rodaje {
	
	int anioRodaje
	
	new(int anioRodaje, String titulo, int puntaje, String genero, List<Funcion> funciones){
		super(titulo, puntaje, genero, funciones)
		this.anioRodaje = anioRodaje
	}
	
	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
}