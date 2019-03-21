package ar.edu.unsam

import ar.edu.unsam.entrada.Entrada
import ar.edu.unsam.rodaje.Rodaje
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {

	String nombre
	String apellido
	int edad
	List<Usuario> amigos = newArrayList
	double saldo
	List<Entrada> entradas = newArrayList
	
	new(String nombre, String apellido, int edad){
		this.nombre = nombre
		this.apellido = apellido
		this.edad = edad
	}
	
	def esAmigo(Usuario amigo){
		amigos.contains(amigo)
	}
	
	def comprarEntrada(Rodaje rodaje) {
		entradas.add(new Entrada(rodaje, rodaje.precioEntrada))
	}
}