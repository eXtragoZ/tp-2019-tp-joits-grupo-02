package ar.edu.unsam.arena.runnable

import ar.edu.unsam.funcion.Funcion
import ar.edu.unsam.repos.RepoRodajes
import ar.edu.unsam.repos.RepoUsuarios
import ar.edu.unsam.rodaje.Pelicula
import ar.edu.unsam.rodaje.Rodaje
import ar.edu.unsam.rodaje.Saga
import ar.edu.unsam.usuario.Usuario
import java.time.LocalDateTime
import java.util.Random
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

class JoitsBootstrap extends CollectionBasedBootstrap {

	override run() {
		val salas = newArrayList("A", "B", "C", "Premium")
		val repoRodajes = new RepoRodajes => [
			ApplicationContext.instance.configureSingleton(Rodaje, it)
			create(new Pelicula(1, 1972, "The Godfather", 9.2f, "Crime, Drama"))
			create(new Pelicula(1974, "The Godfather: Part II", 9.0f, "Crime, Drama"))
			create(new Pelicula(1999, "Fight Club", 8.8f, "Drama"))
			create(new Pelicula(1994, "Forrest Gump", 8.8f, "Drama, Romance"))
			create(new Pelicula(2010, "Inception", 8.8f, "Action, Adventure, Sci-Fi"))
			create(new Pelicula(1999, "Matrix", 8.7f, "Action, Sci-Fi "))
			create(new Pelicula(2014, "Interstellar", 8.6f, "Adventure, Drama, Sci-Fi"))
			create(new Pelicula(2019, "Captain Marvel", 7.1f, "Action, Adventure, Sci-Fi"))
			create(
				new Saga(#[allInstances.get(0) as Pelicula, allInstances.get(1) as Pelicula], "The Godfather Collection", 2000,
					9.2f, "Crime, Drama", 9))

		]

		repoRodajes.recomendados => [
			add(repoRodajes.allInstances.get(1))
			add(repoRodajes.allInstances.get(3))
			add(repoRodajes.allInstances.get(6))
		]

		repoRodajes.allInstances.forEach [
			val iFun = new Random().nextInt(12) + 3
			for (var i = 0; i < iFun; i++) {
				val hours = new Random().nextInt(64) + -6
				funciones.add(
					new Funcion(it, LocalDateTime.now.plusHours(hours),
						"Sala " + salas.get(new Random().nextInt(salas.size))))
			}
		]

		val repoUsuarios = new RepoUsuarios => [
			ApplicationContext.instance.configureSingleton(Usuario, it)
			create(new Usuario("a", "Nombre", "Apeliido", 30, ""))
			create(new Usuario("cgarcia", "Carlos", "García", 25, "1234") => [
				saldo = 1000
			])

		]
		repoUsuarios.allInstances.get(1).amigos.add(repoUsuarios.allInstances.get(0))
		repoUsuarios.allInstances.get(1).comprarEntrada(repoRodajes.searchById(1))
	}

}
