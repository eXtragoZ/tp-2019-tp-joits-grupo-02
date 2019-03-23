package ar.edu.unsam.arena.model

import ar.edu.unsam.usuario.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class PanelDeControlModel {

	Usuario usuario

	new(Usuario usuario) {
		this.usuario = usuario
	}

}
