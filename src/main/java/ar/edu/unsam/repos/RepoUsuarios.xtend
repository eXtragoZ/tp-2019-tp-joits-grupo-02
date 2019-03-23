package ar.edu.unsam.repos

import ar.edu.unsam.usuario.Usuario
import java.util.List

class RepoUsuarios implements Repo<Usuario> {
	
	List<Usuario> usuarios = newArrayList
		
	override allInstances() {
		usuarios
	}
	
	override create(Usuario object) {
		usuarios.add(object)
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
	
}