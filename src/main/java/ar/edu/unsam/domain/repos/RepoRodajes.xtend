package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.rodaje.Pelicula
import ar.edu.unsam.domain.rodaje.Rodaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoRodajes extends RepoDefault<Rodaje> {

	@Accessors
	List<Rodaje> recomendados = newArrayList

	def createExample() {
		new Pelicula
	}

//	def delete(Rodaje object) {
//		rodajes.remove(object)
//	}

	override getEntityType() {
		Rodaje
	}

	//reemplazar despues el allInstance
	override searchById(long _id) {
		allInstances.findFirst[id == _id]
	}

	def searchByString(String valor) {
		allInstances.findFirst[titulo == valor]
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Rodaje> query, Root<Rodaje> camposCandidato, Rodaje t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
