package ar.edu.unsam.rodaje

import java.util.List
import ar.edu.unsam.funcion.Funcion
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity

@Accessors
abstract class Rodaje extends Entity {

	String titulo
	float puntaje
	String genero
	List<Funcion> funciones = newArrayList
	double precioBase
	
	new() {
		super()
	}
	
	new(String titulo, float puntaje, String genero){
		this.titulo = titulo
		this.puntaje = puntaje
		this.genero = genero
	}
	
	abstract def getPrecioEntrada()
	
}