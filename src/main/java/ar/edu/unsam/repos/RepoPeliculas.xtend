package ar.edu.unsam.repos

import ar.edu.unsam.rodaje.Pelicula
import java.util.List
import org.uqbar.commons.model.Repo

class RepoPeliculas implements Repo<Pelicula> {
	
	List<Pelicula> peliculas = newArrayList
		
	override allInstances() {
		peliculas
	}
	
	override create(Pelicula object) {
		peliculas.add(object)
	}
	
	override createExample() {
		new Pelicula
	}
	
	override delete(Pelicula object) {
		peliculas.remove(object)
	}
	
	override getEntityType() {
		Pelicula
	}
	
	override searchByExample(Pelicula example) {
		peliculas.filter[tieneValorBuscado(example.titulo)].toList
	}
	
	override searchById(int _id) {
		peliculas.findFirst[id == _id]
	}
	
	override update(Pelicula object) {
		delete(searchById(object.id))
		create(object)
	}
	
}