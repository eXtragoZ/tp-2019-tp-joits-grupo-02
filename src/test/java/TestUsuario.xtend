import ar.edu.unsam.Usuario
import org.junit.Assert
import org.junit.Test

class TestUsuario {

	var carlos = new Usuario("Carlos", "García", 25)
	var david = new Usuario("David", "Lebón", 25)
	var rodolfo = new Usuario("Rodolfo", "Páez", 20)

	@Test
	def void probarSaldoCarlos() {
		carlos.saldo = 100
		Assert.assertEquals(100, carlos.saldo, 0.1)
	}

	@Test
	def void sonAmigos() {
		carlos.amigos.add(david)
		Assert.assertEquals(true, carlos.esAmigo(david))
	}

	@Test
	def void carlosCompraEntrada() {
		Assert.assertEquals(0, carlos.entradas.size)
		carlos.comprarEntrada(TestRodaje.elPadrino)
		Assert.assertEquals(1, carlos.entradas.size)
	}

}
