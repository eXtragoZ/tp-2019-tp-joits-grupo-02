package ar.edu.unsam.arena.model

import ar.edu.unsam.usuario.Usuario
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Dependencies

@Observable
@Accessors
class PanelDeControlModel {

	Usuario usuario
	Usuario seleccionado
	
	int edadAnterior
	double saldoAnterior
	
	double saldoNuevo

	new(Usuario usuario) {
		this.usuario = usuario
		this.edadAnterior = usuario.edad
		this.saldoAnterior = usuario.saldo
	}

	def cancelarCambios() {
		this.usuario.edad = this.edadAnterior
		this.usuario.saldo = this.saldoAnterior
	}
	
	def cargarSaldo() {
		this.usuario.saldo = this.usuario.saldo + saldoNuevo
	}
	
	@Dependencies("saldoNuevo")
	def getValidar() {
		!Double.isNaN(this.saldoNuevo) && this.saldoNuevo > 0
	}

}
