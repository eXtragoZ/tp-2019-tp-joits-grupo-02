package ar.edu.unsam.arena.model

import ar.edu.unsam.usuario.Usuario
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class PanelDeControlModel {

	Usuario usuario
	
	int edadAnterior
	double saldoAnterior
	List<Usuario> amigosAnteriores = new ArrayList
	
	double saldoNuevo

	new(Usuario usuario) {
		this.usuario = usuario
		this.edadAnterior = usuario.edad
		this.saldoAnterior = usuario.saldo
		this.amigosAnteriores = usuario.amigos
	}

	def cancelarCambios() {
		this.usuario.edad = this.edadAnterior
		this.usuario.saldo = this.saldoAnterior
		this.usuario.amigos = this.amigosAnteriores
	}
	
	def cargarSaldo() {
		this.usuario.saldo = this.usuario.saldo + saldoNuevo
	}

}
