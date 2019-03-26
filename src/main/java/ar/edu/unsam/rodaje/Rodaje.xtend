package ar.edu.unsam.rodaje

import ar.edu.unsam.funcion.Funcion
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
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

	new(String titulo, int anio, float puntaje, String genero) {
		this.titulo = titulo
		this.anio = anio
		this.puntaje = puntaje
		this.genero = genero
	}

	def double getPrecioEntrada() {
		this.precioBase
	}

	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
}
