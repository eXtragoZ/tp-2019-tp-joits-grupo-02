package ar.edu.unsam

import ar.edu.unsam.entrada.Entrada
import ar.edu.unsam.rodaje.Rodaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.apache.commons.lang.StringUtils

@Accessors
class Usuario {

	long id
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
	
	def validar(String password){
		this.password == password
	}
	
	def esAmigo(Usuario amigo){
		amigos.contains(amigo)
	}
	

	def comprarEntrada(Rodaje rodaje) {
		entradas.add(new Entrada(rodaje, rodaje.precioEntrada))
   }

	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(nombre, valorBusqueda) || StringUtils.containsIgnoreCase(apellido, valorBusqueda)
	}
  
}