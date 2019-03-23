package ar.edu.unsam.arena.model

import ar.edu.unsam.Usuario
import ar.edu.unsam.repos.Repo
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class LoginModel {

	String nombreUsuario
	String password

	@Dependencies("usuario", "password")
	def getValidar() {
		return StringUtils.isNotBlank(nombreUsuario) && StringUtils.isNotBlank(password)
	}

	def getUsuario() {
		repoUsuario.searchByString(nombreUsuario, password)
	}
	
	def repoUsuario() {
		ApplicationContext.instance.getSingleton(Usuario) as Repo<Usuario>
	}

}
