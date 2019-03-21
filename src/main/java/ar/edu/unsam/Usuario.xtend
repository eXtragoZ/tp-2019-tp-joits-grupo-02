package ar.edu.unsam

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Usuario {

	String nombre
	String apellido
	int edad
	List<Usuario> amigos = newArrayList
	double saldo
	
	new(String nombre, String apellido, int edad){
		this.nombre = nombre
		this.apellido = apellido
		this.edad = edad
	}
	
	def esAmigo(Usuario amigo){
		amigos.contains(amigo)
	}
}