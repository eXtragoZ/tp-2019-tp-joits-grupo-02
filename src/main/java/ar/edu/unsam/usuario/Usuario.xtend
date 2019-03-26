package ar.edu.unsam.usuario

import ar.edu.unsam.funcion.Funcion
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class Usuario {

	long id
	String nombreUsuario
	String nombre
	String apellido
	int edad
	List<Usuario> amigos = newArrayList
	double saldo
	List<Funcion> entradas = newArrayList
	String password

	new() {
	}

	new(String nombreUsuario, String nombre, String apellido, int edad, String password) {
		this.nombreUsuario = nombreUsuario
		this.nombre = nombre
		this.apellido = apellido
		this.edad = edad
		this.password = password
	}

	def validarPassword(String password) {
		if (this.password != StringUtils.defaultString(password)) {
			throw new UserException("La password es incorrecta")
		}
	}

	def esAmigo(Usuario amigo) {
		amigos.contains(amigo)
	}

	def comprarEntrada(Funcion funcion) {
		this.reducirSaldo(funcion.precio)
		entradas.add(funcion)
	}

	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(nombre, valorBusqueda) ||
			StringUtils.containsIgnoreCase(apellido, valorBusqueda)
	}
	
	def reducirSaldo(Double valor) {
		this.saldo -= valor
	}
	
	def getPeliculasVistas(){
		entradas.map[rodaje].toSet
	}

}
