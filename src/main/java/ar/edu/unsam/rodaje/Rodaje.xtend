package ar.edu.unsam.rodaje

import ar.edu.unsam.funcion.Funcion
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Rodaje {

	long id
	String titulo
	float puntaje
	String genero
	List<Funcion> funciones = newArrayList
	double precioBase
	int anio

	new() {
		super()
	}

	new(String titulo, float puntaje, String genero) {
		this.titulo = titulo
		this.puntaje = puntaje
		this.genero = genero
	}

	abstract def double getPrecioEntrada()
	abstract def boolean tieneValorBuscado(String valorBusqueda)
	
	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
}
