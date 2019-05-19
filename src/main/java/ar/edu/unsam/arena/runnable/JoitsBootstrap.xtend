package ar.edu.unsam.arena.runnable

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import ar.edu.unsam.domain.usuario.Usuario
import ar.edu.unsam.repos.RepoPeliculasMongoDB
import ar.edu.unsam.repos.RepoUsuarios
import java.time.LocalDateTime
import java.util.Random
import java.util.Set
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import redis.clients.jedis.Jedis

class JoitsBootstrap extends CollectionBasedBootstrap {
	
	override run() {
		
//		RepoRodajes.instance => [
//			create(new Pelicula(1972, "The Godfather", 9.2f, "Crime, Drama", this.getFuncionesRandom()))
//			create(new Pelicula(1974, "The Godfather: Part II", 9.0f, "Crime, Drama", this.getFuncionesRandom()))
//			create(new Pelicula(1999, "Fight Club", 8.8f, "Drama", this.getFuncionesRandom()))
//			create(new Pelicula(1994, "Forrest Gump", 8.8f, "Drama, Romance", this.getFuncionesRandom()))
//			create(new Pelicula(2010, "Inception", 8.8f, "Action, Adventure, Sci-Fi", this.getFuncionesRandom()))
//			create(new Pelicula(1999, "Matrix", 8.7f, "Action, Sci-Fi ", this.getFuncionesRandom()))
//			create(new Pelicula(2014, "Interstellar", 8.6f, "Adventure, Drama, Sci-Fi", this.getFuncionesRandom()))
//			create(new Pelicula(2019, "Captain Marvel", 7.1f, "Action, Adventure, Sci-Fi", this.getFuncionesRandom()))
//			create(
//				new Saga(#[allInstances.get(0) as Pelicula, allInstances.get(1) as Pelicula].toSet,
//					"The Godfather Collection", 2000, 9.2f, "Crime, Drama", 9, this.getFuncionesRandom()))
//
//		]

		val padrino = new Pelicula(1972, "The Godfather", 9.2f, "Crime, Drama", this.getFuncionesRandom())
		RepoPeliculasMongoDB.instance.createIfNotExists(padrino)
		
		RepoPeliculasMongoDB.instance => [
			createIfNotExists(new Pelicula(1974, "The Godfather: Part II", 9.0f, "Crime, Drama", this.getFuncionesRandom()))
			createIfNotExists(new Pelicula(1999, "Fight Club", 8.8f, "Drama", this.getFuncionesRandom()))
			createIfNotExists(new Pelicula(1994, "Forrest Gump", 8.8f, "Drama, Romance", this.getFuncionesRandom()))
			createIfNotExists(new Pelicula(2010, "Inception", 8.8f, "Action, Adventure, Sci-Fi", this.getFuncionesRandom()))
			createIfNotExists(new Pelicula(1999, "Matrix", 8.7f, "Action, Sci-Fi ", this.getFuncionesRandom()))
			createIfNotExists(new Pelicula(2014, "Interstellar", 8.6f, "Adventure, Drama, Sci-Fi", this.getFuncionesRandom()))
			createIfNotExists(new Pelicula(2019, "Captain Marvel", 7.1f, "Action, Adventure, Sci-Fi", this.getFuncionesRandom()))
//			save(
//				new Saga(#[f(padrino) as Pelicula, ds.get(1) as Pelicula].toSet,
//					"The Godfather Collection", 2000, 9.2f, "Crime, Drama", 9, this.getFuncionesRandom()))
		
		]

		RepoUsuarios.instance => [
			create(new Usuario("a", "Nombre", "Apeliido", 30, "") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("cgarcia", "Carlos", "García", 25, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("osc", "Óscar", "Alvarez", 30, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("rub", "Rubén", "Carmona", 30, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("hug", "Hugo", "Ferrer", 30, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("mar", "Marcos", "Guerrero", 30, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("rau", "Raúl", "Romero", 30, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])
			create(new Usuario("san", "Santiago", "Vargas", 30, "1234") => [
				saldo = 1000
				entradas = #[this.entradaRandom, this.entradaRandom].toSet
			])

		]

		val usuario = RepoUsuarios.instance.searchById(RepoUsuarios.instance.allInstances.get(1).id)
		usuario.amigos = #[RepoUsuarios.instance.allInstances.get(0)].toSet
		RepoUsuarios.instance.update(usuario)
		
	}
	
	private def Entrada getEntradaRandom() {
		val peliculas = RepoPeliculasMongoDB.instance.allInstances
		val peliculaAux = peliculas.get(new Random().nextInt(peliculas.size))
		val pelicula = RepoPeliculasMongoDB.instance.searchById(peliculaAux.id)
		val funciones = pelicula.funciones
		val funcion = funciones.get(new Random().nextInt(funciones.size))
		new Entrada(pelicula, funcion)
	}
	
	private def Set<Funcion> getFuncionesRandom() {
		val salas = newHashSet("A", "B", "C", "Premium")
		val iFun = new Random().nextInt(12) + 3
		var Set<Funcion> funciones = newHashSet
		for (var i = 0; i < iFun; i++) {
			val hours = new Random().nextInt(64) + -6
			funciones.add(
				new Funcion(LocalDateTime.now.plusHours(hours),
					"Sala " + salas.get(new Random().nextInt(salas.size))))
		}
		funciones
	}
	
	override isPending(){
		RepoUsuarios.instance.allInstances.isEmpty
	}
	
}
