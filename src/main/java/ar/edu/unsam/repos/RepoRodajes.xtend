package ar.edu.unsam.repos

import ar.edu.unsam.rodaje.Pelicula
import ar.edu.unsam.rodaje.Rodaje
import java.util.List

class RepoRodajes implements Repo<Rodaje> {

	List<Rodaje> rodajes = newArrayList
	int nextId = 1

	override allInstances() {
		rodajes
	}

	override create(Rodaje object) {
		object.id = this.nextId
		rodajes.add(object)
		this.nextId++
	}

	override createExample() {
		new Pelicula
	}

	override delete(Rodaje object) {
		rodajes.remove(object)
	}

	override getEntityType() {
		Rodaje
	}

	override searchByExample(Rodaje example) {
		rodajes.filter[tieneValorBuscado(example.titulo)].toList
	}

	override searchById(long _id) {
		rodajes.findFirst[id == _id]
	}

	override update(Rodaje object) {
		delete(searchById(object.id))
		create(object)
	}

	override searchByString(String valor) {
	}

}
