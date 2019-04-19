import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import ar.edu.unsam.domain.pelicula.Saga
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test

class TestRodaje {
	
	var elPadrino = new Pelicula(1972, "The Godfather", 9.2f, "Crime, Drama")
	var elPadrino2 = new Pelicula(1974, "The Godfather: Part II", 9.0f, "Crime, Drama")
	var clubDeLaPelea = new Pelicula(1999, "Fight Club", 8.8f, "Drama")
//	var correForrest = new Pelicula(1994, "Forrest Gump", 8.8f, "Drama, Romance")
//	var inception = new Pelicula(2010, "Inception", 8.8f, "Action, Adventure, Sci-Fi")
//	var matrix = new Pelicula(1999, "Matrix", 8.7f, "Action, Sci-Fi ")
//	var interestelar = new Pelicula(2014, "Interstellar", 8.6f, "Adventure, Drama, Sci-Fi")
//	var capitanaMarvel = new Pelicula(2019, "Captain Marvel", 7.1f, "Action, Adventure, Sci-Fi")
	var sagaElPadrino = new Saga(#[elPadrino, elPadrino2].toSet, "The Godfather Saga",2000, 9.4f, "Crime, Drama", 6)
	
	def static getElPadrino() {
		new Pelicula(1972, "The Godfather", 9.2f, "Crime, Drama")
	}
	
	@Test
	def void probarClubDeLaPelea(){
		Assert.assertEquals(30, clubDeLaPelea.precioEntrada, 0.1)
	}
	
	@Test
	def void probarSagaElPadrino(){
		sagaElPadrino.funciones = #[new Funcion(sagaElPadrino, LocalDateTime.now, "Hoyts El Padrino")].toSet
		Assert.assertEquals(200, sagaElPadrino.precioEntrada, 0.1)
	}
	
}