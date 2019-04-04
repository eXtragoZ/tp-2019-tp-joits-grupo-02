package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.usuario.Usuario
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoUsuarios extends RepoDefault<Usuario> {

	override create(Usuario object) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(object)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
		}
	}

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
//
//	override searchByString(String valor) {
//		usuarios.findFirst[nombreUsuario.equals(valor)]
//	}
	def amigosRecomendados(Usuario usuario) {
		#[allInstances.get(0), allInstances.get(4), allInstances.get(5)]
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Usuario t) {
		if (t.nombre !== null) {
			query.where(criteria.equal(camposUsuario.get("descripcion"), t.nombre))
		}

	}

	override getEntityType() {
		Usuario
	}
	
}
