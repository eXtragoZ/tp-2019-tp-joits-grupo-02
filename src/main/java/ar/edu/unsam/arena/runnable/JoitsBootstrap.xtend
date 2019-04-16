package ar.edu.unsam.arena.runnable

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.repos.RepoRodajes
import ar.edu.unsam.domain.repos.RepoUsuarios
import ar.edu.unsam.domain.rodaje.Rodaje
import ar.edu.unsam.domain.rodaje.Saga
import ar.edu.unsam.domain.usuario.Usuario
import java.time.LocalDateTime
import java.util.ArrayList
import java.util.List
import java.util.Random
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

class JoitsBootstrap extends CollectionBasedBootstrap {

	override run() {
//		val salas = newArrayList("A", "B", "C", "Premium")
		RepoRodajes.instance => [
			ApplicationContext.instance.configureSingleton(Rodaje, it)
			create(new Rodaje(1972, "The Godfather", 9.2f, "Crime, Drama", this.getFuncionesRandom()))
			create(new Rodaje(1974, "The Godfather: Part II", 9.0f, "Crime, Drama", this.getFuncionesRandom()))
			create(new Rodaje(1999, "Fight Club", 8.8f, "Drama", this.getFuncionesRandom()))
			create(new Rodaje(1994, "Forrest Gump", 8.8f, "Drama, Romance", this.getFuncionesRandom()))
			create(new Rodaje(2010, "Inception", 8.8f, "Action, Adventure, Sci-Fi", this.getFuncionesRandom()))
			create(new Rodaje(1999, "Matrix", 8.7f, "Action, Sci-Fi ", this.getFuncionesRandom()))
			create(new Rodaje(2014, "Interstellar", 8.6f, "Adventure, Drama, Sci-Fi", this.getFuncionesRandom()))
			create(new Rodaje(2019, "Captain Marvel", 7.1f, "Action, Adventure, Sci-Fi", this.getFuncionesRandom()))
			create(
				new Saga(#[allInstances.get(0) as Rodaje, allInstances.get(1) as Rodaje], "The Godfather Collection", 2000,
					9.2f, "Crime, Drama", 9, this.getFuncionesRandom()))

		]

		RepoRodajes.instance.recomendados => [
			add(RepoRodajes.instance.allInstances.get(1))
			add(RepoRodajes.instance.allInstances.get(3))
			add(RepoRodajes.instance.allInstances.get(6))
		]

//		repoRodajes.allInstances.forEach [
//			getFuncionesRandom(it)
//		]

		RepoUsuarios.instance => [
			ApplicationContext.instance.configureSingleton(Usuario, it)
			create(new Usuario("a", "Nombre", "Apeliido", 30, ""))
			create(new Usuario("cgarcia", "Carlos", "García", 25, "1234") => [
				saldo = 1000
			])
			create(new Usuario("osc", "Óscar", "Alvarez", 30, "1234"))
			create(new Usuario("rub", "Rubén", "Carmona", 30, "1234"))
			create(new Usuario("hug", "Hugo", "Ferrer", 30, "1234"))
			create(new Usuario("mar", "Marcos", "Guerrero", 30, "1234"))
			create(new Usuario("rau", "Raúl", "Romero", 30, "1234"))
			create(new Usuario("san", "Santiago", "Vargas", 30, "1234"))

		]
//		repoUsuarios.allInstances.forEach[
//			val iFun = new Random().nextInt(3) + 2
//			for (var i = 0; i < iFun; i++) {
//				val rodaje = repoRodajes.allInstances.get(new Random().nextInt(repoRodajes.allInstances.size))
//				val funciones = rodaje.funciones
//				val funcion = funciones.get(new Random().nextInt(funciones.size))
//				entradas.add(new Entrada(rodaje, funciones.get(new Random().nextInt(funciones.size))))
//			}
//		]
//		repoUsuarios.allInstances.get(1).amigos.add(repoUsuarios.allInstances.get(0))
	}
	
	private def List<Funcion> getFuncionesRandom() {
		val salas = newArrayList("A", "B", "C", "Premium")
		val iFun = new Random().nextInt(12) + 3
		var List<Funcion> funciones = new ArrayList
		for (var i = 0; i < iFun; i++) {
			val hours = new Random().nextInt(64) + -6
			funciones.add(
				new Funcion(LocalDateTime.now.plusHours(hours),
					"Sala " + salas.get(new Random().nextInt(salas.size))))
		}
		funciones
	}
	
	override isPending(){
		RepoUsuarios.instance.allInstances === null
	}
	

}
