package ar.edu.unsam.rodaje

import ar.edu.unsam.funcion.Funcion
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Pelicula extends Rodaje {
	
	int anioRodaje
	
	new(int anioRodaje, String titulo, int puntaje, String genero, List<Funcion> funciones){
		super(titulo, puntaje, genero, funciones)
		this.anioRodaje = anioRodaje
	}
}