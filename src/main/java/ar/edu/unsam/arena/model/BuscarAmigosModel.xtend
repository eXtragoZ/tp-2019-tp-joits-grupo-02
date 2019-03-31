package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.repos.RepoUsuarios
import ar.edu.unsam.domain.usuario.Usuario
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils

@Observable
@Accessors
class BuscarAmigosModel {

	Usuario usuario
	Usuario seleccionado
	String busquedaIngresada
	String busquedaActual

	new(Usuario usuario) {
		this.usuario = usuario
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "listaDeBusqueda")
		ObservableUtils.firePropertyChanged(this, "busquedaRecomendada")
	}

	def getListaDeBusqueda() {
		if (StringUtils.isBlank(busquedaActual)) {
			this.listaDePersonas
		} else {
			this.listaDePersonas.filter[tieneValorBuscado(busquedaActual)].toList
		}
	}
	
	private def List<Usuario> getListaDePersonas() {
		this.getNoSonAmigos(this.repoUsuario.allInstances)
	}

	def getBusquedaRecomendada() {
		this.getNoSonAmigos(this.repoUsuario.amigosRecomendados(this.usuario))
	}
	
	def getNoSonAmigos(List<Usuario> usuarios) {
		usuarios.filter[!usuario.esAmigo(it)].toList
	}
	
	def repoUsuario() {
		ApplicationContext.instance.getSingleton(Usuario) as RepoUsuarios
	}
	
	def agregarAmigo() {
		this.usuario.amigos.add(this.seleccionado)
		ObservableUtils.firePropertyChanged(this, "listaDeBusqueda")
		ObservableUtils.firePropertyChanged(this, "busquedaRecomendada")
	}

}
