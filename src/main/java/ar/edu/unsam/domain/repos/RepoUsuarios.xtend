package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.usuario.Usuario
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import javax.persistence.criteria.JoinType

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

	def createExample() {
		new Usuario
	}

//	def delete(Usuario object) {
//		usuarios.remove(object)
//	}

	override searchById(long _id) {
		val entityManager = entityManager
		println(_id)
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch("amigos", JoinType.LEFT)
//			from.fetch("entradas")
			query.select(from)
			query.where(criteria.equal(from.get("id"), _id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

//	override update(Usuario object) {
//		delete(searchById(object.id))
//		create(object)
//	}

	def searchByString(String nombreUsuario) {
		val entityManager = entityManager
        try {
            val criteria = entityManager.criteriaBuilder
            val query = criteria.createQuery(entityType)
            val camposUsuario = query.from(entityType)
//            val camposCandidato = camposZona.fetch("candidatos")
//            camposCandidato.fetch("partido")
            query.select(camposUsuario)
            query.where(criteria.equal(camposUsuario.get("nombreUsuario"), nombreUsuario))
            entityManager.createQuery(query).singleResult
        } finally {
            entityManager?.close
        }
	}

	def amigosRecomendados(Usuario usuario) {
		#[allInstances.get(0), allInstances.get(4), allInstances.get(5)]
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
