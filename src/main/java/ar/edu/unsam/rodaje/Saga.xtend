package ar.edu.unsam.rodaje

import java.util.List
import ar.edu.unsam.funcion.Funcion

class Saga extends Rodaje {
	
	List<Pelicula> peliculas
	int nivelDeClasico
	val PLUS = 5
	
	new(){
		super()
		this.precioBase = 10.00
	}
	
	new(List<Pelicula> peliculas, String titulo, float puntaje, String genero, int nivelDeClasico){
		super(titulo, puntaje, genero)
		this.peliculas = peliculas
		this.nivelDeClasico = nivelDeClasico
		this.precioBase = 10.00
	}
	
	def getPrecioBasePorPeliculas() {
		this.precioBase * this.peliculas.size * this.nivelDeClasico
	}
	
	def precioPorFuncion() {
		this.funciones.fold(0.00, [total, funcion | total + funcion.getPrecioPorDiaDeFuncion])
	}
	
	override getPrecioEntrada() {
		this.getPrecioBasePorPeliculas() + this.precioPorFuncion
	}
	
	override tieneValorBuscado(String valorBusqueda) {
		this.peliculas.exists[pelicula | pelicula.tieneValorBuscado(valorBusqueda)]
	}
	
}