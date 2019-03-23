package ar.edu.unsam.arena.model

import ar.edu.unsam.repos.Repo
import ar.edu.unsam.usuario.Usuario
import java.util.ArrayList
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
	List<Usuario> amigosFiltrados = new ArrayList
	String busquedaIngresada
	String busquedaActual

	new(Usuario usuario) {
		this.usuario = usuario
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "listaDeBusqueda")
	}

	def getListaDeBusqueda() {
		if (StringUtils.isBlank(busquedaActual)) {
			this.amigosFiltrados = this.usuario.amigos
		} else {
			this.usuario.amigos.filter[tieneValorBuscado(busquedaActual)].toList
		}
	}

	def getBusquedaRecomendada() {
		val List<Usuario> amigos = #[new Usuario("ggonzales", "Gabriel", "Gonzalez", 40, "1234")]
		return amigos
	}
	
	def repoUsuario() {
		ApplicationContext.instance.getSingleton(Usuario) as Repo<Usuario>
	}
	
	def agregarAmigo() {
		this.usuario.amigos.add(this.seleccionado)
		ObservableUtils.firePropertyChanged(this, "listaDeBusqueda")
	}

}
