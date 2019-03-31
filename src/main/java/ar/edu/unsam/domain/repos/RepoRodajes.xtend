package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.rodaje.Pelicula
import ar.edu.unsam.domain.rodaje.Rodaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class RepoRodajes implements Repo<Rodaje> {

	List<Rodaje> rodajes = newArrayList
	int nextId = 1
	@Accessors
	List<Rodaje> recomendados = newArrayList

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
		rodajes.findFirst[titulo == valor]
	}

}
