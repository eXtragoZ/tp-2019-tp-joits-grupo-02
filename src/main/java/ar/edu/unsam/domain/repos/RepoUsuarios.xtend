package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.usuario.Usuario
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
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

//	override create(Usuario object) {
//		val entityManager = this.entityManager
//		try {
//			entityManager => [
//				transaction.begin
//				persist(object)
//				transaction.commit
//			]
//		} catch (PersistenceException e) {
//			e.printStackTrace
//			entityManager.transaction.rollback
//			throw new RuntimeException("Ocurrió un error en Repo de usuarios, la operación no puede completarse", e)
//		} finally {
//			entityManager.close
//		}
//	}

	def createExample() {
		new Usuario
	}

//	def delete(Usuario object) {
//		usuarios.remove(object)
//	}

	override searchById(long _id) {
		allInstances.findFirst[id == _id]
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
