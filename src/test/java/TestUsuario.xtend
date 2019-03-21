import ar.edu.unsam.Usuario
import org.junit.Assert
import org.junit.Test

class TestUsuario {
	
	var carlos = new Usuario("Carlos", "García", 25, "1234")
	var david = new Usuario("David", "Lebón", 25, "1234")
	var rodolfo = new Usuario("Rodolfo", "Páez", 20, "1234")
	
	@Test
	def void coincideSaldoUsuario(){
		carlos.saldo = 100
		Assert.assertEquals(100, carlos.saldo, 0.1)
	}

	def void noCoincideSaldoUsuario(){
		carlos.saldo = 100
		Assert.assertNotEquals(200, carlos.saldo)
	}
	
	@Test
	def void sonAmigos(){
		carlos.amigos.add(david)
		Assert.assertTrue(carlos.esAmigo(david))
	}
	
	@Test
	def void noSonAmigos(){
		rodolfo.amigos.add(carlos)
		Assert.assertFalse(carlos.esAmigo(rodolfo))
	}
	
	@Test
	def void encuentroUsuario(){
		Assert.assertTrue(carlos.tieneValorBuscado("gAR"))
	}

	@Test
	def void carlosCompraEntrada() {
		Assert.assertEquals(0, carlos.entradas.size)
		carlos.comprarEntrada(TestRodaje.elPadrino)
		Assert.assertEquals(1, carlos.entradas.size)
	}
	
	@Test
	def void noEncuentroUsuario(){
		Assert.assertFalse(carlos.tieneValorBuscado("Páez"))
	}
}
