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
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Rodaje> query, Root<Rodaje> camposRodaje, Rodaje t) {
		if (t.titulo !== null) {
			query.where(criteria.equal(camposRodaje.get("titulo"), t.titulo))
		}
	}
	
//	override List<Rodaje> allInstances() {
//		val entityManager = this.entityManager
//		try {
//			val criteria = entityManager.criteriaBuilder
//			val query = criteria.createQuery(entityType)
//			val from = query.from(entityType)
//			from.fetch("funciones")
//			query.select(from)
//			entityManager.createQuery(query).resultList
//		} finally {
//			entityManager?.close
//		}
//	}

}
