package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.usuario.Usuario
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

class RepoUsuarios extends RepoDefault<Usuario> {
	
	static RepoUsuarios instance
	
	private new(){}
	
	def static getInstance(){
		if(instance === null){
			instance = new RepoUsuarios
		}else {
			instance
		}
	}

	override searchById(long _id) {
		val entityManager = generateEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("amigos", JoinType.LEFT)
			val fetchEntrada = camposUsuario.fetch("entradas", JoinType.LEFT)
//			fetchEntrada.fetch("pelicula", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), _id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	def searchByString(String nombreUsuario) {
		val entityManager = generateEntityManager
        try {
            val criteria = entityManager.criteriaBuilder
            val query = criteria.createQuery(entityType)
            val camposUsuario = query.from(entityType)
            camposUsuario.fetch("entradas", JoinType.LEFT)
            query.select(camposUsuario)
            query.where(criteria.equal(camposUsuario.get("nombreUsuario"), nombreUsuario))
            entityManager.createQuery(query).singleResult
        } finally {
            entityManager?.close
        }
	}

	def amigosRecomendados(Usuario usuario) {
		val entityManager = generateEntityManager
        try {
            val criteria = entityManager.criteriaBuilder
            val query = criteria.createQuery(entityType)
            val camposUsuario = query.from(entityType)
            query.select(camposUsuario)
            query.where(criteria.notEqual(camposUsuario.get("id"), usuario.id))
            query.orderBy(criteria.desc(camposUsuario.get("saldo")))
            val queryResult = entityManager.createQuery(query)
            queryResult.maxResults = 3
            queryResult.resultList
        } finally {
            entityManager?.close
        }
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Usuario t) {
		if (t.nombreUsuario !== null) {
			query.where(criteria.equal(camposUsuario.get("nombreUsuario"), t.nombreUsuario))
		}

	}

	override getEntityType() {
		Usuario
	}
	
}
