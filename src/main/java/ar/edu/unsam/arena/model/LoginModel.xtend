package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.repos.RepoUsuarios
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@Observable
class LoginModel {

	String nombreUsuario
	String password
	String mensaje = "Ingrese su usuario y password"

	@Dependencies("nombreUsuario", "password")
	def getValidar() {
		return StringUtils.isNotBlank(nombreUsuario)// && StringUtils.isNotBlank(password)
	}

	def obtenerUsuario() {
		val usuario = repoUsuario.searchByString(nombreUsuario)
		if (usuario === null) {
			throw new UserException("El usuario no existe")
		}
		usuario.validarPassword(password)
		usuario
	}
	
	def repoUsuario() {
		RepoUsuarios.instance
	}
}
