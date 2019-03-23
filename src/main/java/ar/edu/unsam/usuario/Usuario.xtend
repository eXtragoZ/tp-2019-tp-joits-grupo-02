package ar.edu.unsam.usuario

import ar.edu.unsam.entrada.Entrada
import ar.edu.unsam.rodaje.Rodaje
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Usuario {

	long id
	String userName
	String nombre
	String apellido
	int edad
	List<Usuario> amigos = newArrayList
	double saldo
	List<Entrada> entradas = newArrayList
	String password

	
	new(){}
	
	new(String nombre, String apellido, int edad, String password){
		this.nombre = nombre
		this.apellido = apellido
		this.edad = edad
		this.password = password
	}
	
	new(String userName, String nombre, String apellido, int edad, String password){
		this.userName = userName
		this.nombre = nombre
		this.apellido = apellido
		this.edad = edad
		this.password = password
	}
	
	def validar(String password){
		this.password == password
	}
	
	def esAmigo(Usuario amigo){
		amigos.contains(amigo)
	}
	

	def comprarEntrada(Rodaje rodaje) {
		entradas.add(new Entrada(rodaje))
   }

	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(nombre, valorBusqueda) || StringUtils.containsIgnoreCase(apellido, valorBusqueda)
	}
  
}
