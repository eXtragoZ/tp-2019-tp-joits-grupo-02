package ar.edu.unsam.rodaje

import java.util.List
import ar.edu.unsam.funcion.Funcion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Rodaje {

	String titulo
	int puntaje
	String genero
	List<Funcion> funciones
	
	new(String titulo, int puntaje, String genero, List<Funcion> funciones){
		this.titulo = titulo
		this.puntaje = puntaje
		this.genero = genero
		this.funciones = funciones
	}
	
}