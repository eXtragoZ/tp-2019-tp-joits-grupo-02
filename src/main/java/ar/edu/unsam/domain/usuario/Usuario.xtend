package ar.edu.unsam.domain.usuario

import ar.edu.unsam.domain.entrada.Entrada
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
	List<Entrada> entradas = newArrayList
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

	def comprarEntrada(Entrada entrada) {
		this.reducirSaldo(entrada.precio)
		entradas.add(entrada)
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
