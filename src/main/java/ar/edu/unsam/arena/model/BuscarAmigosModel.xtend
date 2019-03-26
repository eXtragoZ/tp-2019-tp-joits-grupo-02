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
	List<Usuario> amigosSugeridos = new ArrayList
	String busquedaIngresada
	String busquedaActual

	new(Usuario usuario) {
		this.usuario = usuario
		amigosSugeridos = #[new Usuario("ggonzales", "Gabriel", "Gonzalez", 40, "1234")]
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "listaDeBusqueda")
		ObservableUtils.firePropertyChanged(this, "busquedaRecomendada")
	}

	def getListaDeBusqueda() {
		if (StringUtils.isBlank(busquedaActual)) {
			getListaDePersonas()
		} else {
			this.listaDePersonas.filter[tieneValorBuscado(busquedaActual)].toList
		}
	}
	
	private def List<Usuario> getListaDePersonas() {
		this.getNoSonAmigos(this.repoUsuario.allInstances)
	}

	def getBusquedaRecomendada() {
		this.getNoSonAmigos(this.amigosSugeridos)
	}
	
	def getNoSonAmigos(List<Usuario> lista) {
		lista.filter[ persona | !usuario.esAmigo(persona)].toList
	}
	
	def repoUsuario() {
		ApplicationContext.instance.getSingleton(Usuario) as Repo<Usuario>
	}
	
	def agregarAmigo() {
		this.usuario.amigos.add(this.seleccionado)
		ObservableUtils.firePropertyChanged(this, "listaDeBusqueda")
		ObservableUtils.firePropertyChanged(this, "busquedaRecomendada")
	}

}
