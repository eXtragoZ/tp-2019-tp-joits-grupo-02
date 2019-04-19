package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.pelicula.Pelicula
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors

class RepoRodajes extends RepoDefault<Pelicula> {

	static RepoRodajes instance
	
	private new(){}
	
	def static getInstance(){
		if(instance === null){
			instance = new RepoRodajes
		}else {
			instance
		}
	}
	
	@Accessors
	List<Pelicula> recomendados = newArrayList

	def createExample() {
		new Pelicula
	}

//	def delete(Rodaje object) {
//		rodajes.remove(object)
//	}

	override getEntityType() {
		Pelicula
	}

	//reemplazar despues el allInstance
//	override searchById(long _id) {
//		allInstances.findFirst[id == _id]
//	}

	def searchByString(String valor) {
		allInstances.findFirst[titulo == valor]
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Pelicula> query, Root<Pelicula> camposRodaje, Pelicula t) {
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

	override searchById(long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("funciones")
			query.select(from)
			query.where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
	

}
