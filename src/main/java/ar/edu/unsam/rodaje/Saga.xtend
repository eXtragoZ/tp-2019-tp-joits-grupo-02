package ar.edu.unsam.rodaje

import java.util.List

class Saga extends Rodaje {
	
	List<Pelicula> peliculas
	int nivelDeClasico
	val PLUS = 5
	
	new(){
		super()
		this.precioBase = 10.00
	}
	
	new(List<Pelicula> peliculas, String titulo, float puntaje, String genero){
		super(titulo, puntaje, genero)
		this.peliculas = peliculas
		this.precioBase = 10.00
	}
	
	def getPlus() {
		this.nivelDeClasico * PLUS  
	}
	
	def getPrecioBasePorPeliculas() {
		this.precioBase * this.peliculas.size
	}
	
	def valorPorFuncion() {
		0//a completar
	}
	
	override getPrecioEntrada() {
		this.getPrecioBasePorPeliculas() + this.plus + this.valorPorFuncion
	}
	
}