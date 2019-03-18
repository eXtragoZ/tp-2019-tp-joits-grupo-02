package ar.edu.unsam.arena.runnable

import ar.edu.unsam.repos.RepoPeliculas
import ar.edu.unsam.rodaje.Pelicula
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import java.time.LocalDateTime
import ar.edu.unsam.funcion.Funcion
import java.util.Random

class JoitsBootstrap extends CollectionBasedBootstrap {
	
	override run() {
		val salas = newArrayList("A","B","C","Premium")
		
		new RepoPeliculas => [
			ApplicationContext.instance.configureRepo(Pelicula, it)
			create(new Pelicula(1972, "The Godfather", 9.2f, "Crime, Drama"))
			create(new Pelicula(1974, "The Godfather: Part II", 9.0f, "Crime, Drama"))
			create(new Pelicula(1999, "Fight Club", 8.8f, "Drama"))
			create(new Pelicula(1994, "Forrest Gump", 8.8f, "Drama, Romance"))
			create(new Pelicula(2010, "Inception", 8.8f, "Action, Adventure, Sci-Fi"))
			create(new Pelicula(1999, "Matrix", 8.7f, "Action, Sci-Fi "))
			create(new Pelicula(2014, "Interstellar", 8.6f, "Adventure, Drama, Sci-Fi"))
			create(new Pelicula(2019, "Captain Marvel", 7.1f, "Action, Adventure, Sci-Fi"))
			
			allInstances.forEach[
				val iFun = new Random().nextInt(12) + 3
				for (var i = 0; i < iFun; i++) {
					val hours = new Random().nextInt(64) + -6
					funciones.add(
						new Funcion(LocalDateTime.now.plusHours(hours),
							"Sala " + salas.get(new Random().nextInt(salas.size))))
				}
			]
		]
		
		
	}
	
}