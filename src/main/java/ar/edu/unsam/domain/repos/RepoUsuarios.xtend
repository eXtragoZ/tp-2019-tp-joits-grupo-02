package ar.edu.unsam.domain.repos

import ar.edu.unsam.domain.usuario.Usuario
import java.util.List

class RepoUsuarios implements Repo<Usuario> {
	
	List<Usuario> usuarios = newArrayList
	int nextId = 1
		
	override allInstances() {
		usuarios
	}
	
	override create(Usuario object) {
		object.id = this.nextId
		usuarios.add(object)
		this.nextId++
	}
	
	override createExample() {
		new Usuario
	}
	
	override delete(Usuario object) {
		usuarios.remove(object)
	}
	
	override getEntityType() {
		Usuario
	}
	
	override searchByExample(Usuario example) {
		usuarios.filter[tieneValorBuscado(example.nombre)].toList
	}
	
	override searchById(long _id) {
		usuarios.findFirst[id == _id]
	}
	
	override update(Usuario object) {
		delete(searchById(object.id))
		create(object)
	}
	
	override searchByString(String valor) {
		usuarios.findFirst[nombreUsuario.equals(valor)]
	}
	
	def amigosRecomendados(Usuario usuario) {
		#[allInstances.get(0), allInstances.get(4), allInstances.get(5)]
	}
}