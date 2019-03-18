package ar.edu.unsam.arena.model

import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.apache.commons.lang.StringUtils
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@Observable
class LoginModel {
	String usuario
	String password
	
	@Dependencies("usuario", "password")
	def getValidar() {
		return StringUtils.isNotBlank(usuario)
	}
}