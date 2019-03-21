package ar.edu.unsam.rodaje

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Saga extends Rodaje {
	
	List<Pelicula> peliculas = newArrayList
	int nivelDeClasico
	val PLUS = 5
	
	new(){
		super()
		this.precioBase = 10.00
	}
	new(String titulo, float puntaje, String genero){
		super(titulo, puntaje, genero)
		this.peliculas = peliculas
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