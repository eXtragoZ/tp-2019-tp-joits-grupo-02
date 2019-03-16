package ar.edu.unsam

@Accessors
class Usuario {

	String nombre
	String apellido
	int edad
	List<Usuario> amigos = []
	
}