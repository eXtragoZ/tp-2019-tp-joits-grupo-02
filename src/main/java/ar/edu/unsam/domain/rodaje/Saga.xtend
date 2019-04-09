package ar.edu.unsam.domain.rodaje

import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import ar.edu.unsam.domain.funcion.Funcion

@Entity
@Accessors
@Observable
class Saga extends Rodaje {

	@OneToMany(fetch=FetchType.LAZY)
	List<Rodaje> peliculas = newArrayList
	
	@Column
	int nivelDeClasico
	
	val PLUS = 5

	new() {
		super()
		this.precioBase = 10.00
	}

	new(String titulo, int anio, float puntaje, String genero) {
		super(anio, titulo, puntaje, genero)
		this.peliculas = peliculas
		this.precioBase = 10.00
	}

	new(List<Rodaje> peliculas, String titulo, int anio, float puntaje, String genero, int nivelDeClasico) {
		super(anio, titulo, puntaje, genero)
		this.peliculas = peliculas
		this.nivelDeClasico = nivelDeClasico
		this.precioBase = 10.00
	}
	
	new(List<Rodaje> peliculas, String titulo, int anio, float puntaje, String genero, int nivelDeClasico, List<Funcion> funciones) {
		super(anio, titulo, puntaje, genero, funciones)
		this.peliculas = peliculas
		this.nivelDeClasico = nivelDeClasico
		this.funciones = funciones
		this.precioBase = 10.00
	}

	def precioPorFuncion() {
		this.funciones.fold(0.00, [total, funcion|total + funcion.getPrecioPorDiaDeFuncion])
	}

	override getPrecioEntrada() {
		this.precioBase * this.peliculas.size * this.nivelDeClasico
	}

	override tieneValorBuscado(String valorBusqueda) {
		this.peliculas.exists[pelicula|pelicula.tieneValorBuscado(valorBusqueda)]
	}

}
