package ar.edu.unsam.repos

import ar.edu.unsam.domain.pelicula.Pelicula
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

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

	override getEntityType() {
		Pelicula
	}

//	def searchByString(String valor) {
//		allInstances.findFirst[titulo == valor]
//	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Pelicula> query, Root<Pelicula> camposRodaje, Pelicula t) {
		if (t.titulo !== null) {
			query.where(criteria.equal(camposRodaje.get("titulo"), t.titulo))
		}
	}
	
	override searchById(long id) {
		val entityManager = generateEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("funciones", JoinType.LEFT)
			query.select(from)
			query.where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
	
	
	def getRecomendados() {
		val entityManager = generateEntityManager
        try {
            val criteria = entityManager.criteriaBuilder
            val query = criteria.createQuery(entityType)
            val camposRodaje = query.from(entityType)
            query.select(camposRodaje)
            query.orderBy(criteria.desc(camposRodaje.get("puntaje")))
            val queryResult = entityManager.createQuery(query)
            queryResult.maxResults = 3
            queryResult.resultList
        } finally {
            entityManager?.close
        }
	}

}
