package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import ar.edu.unsam.domain.usuario.Usuario
import ar.edu.unsam.repos.RepoPeliculasMongoDB
import ar.edu.unsam.repos.RepoUsuarios
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.ArrayList
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtext.xbase.lib.Functions.Function1
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils
import redis.clients.jedis.Jedis
import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig

@Accessors
@Observable
class CompraDeTicketsModel {
	val formatterDate = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	
	JedisPool jedisPool
	Usuario usuario
	String busquedaIngresada
	String busquedaActual
	Pelicula peliculaSeleccionado
	Funcion funcionSeleccionada
//	CarritoRedis carritoRedis
	List<Entrada> carrito
	Funcion funcionCarritoSeleccionada
	String mensajeError = ""
	List<Pelicula> peliculas = new ArrayList

	new(Usuario usuario) {
		this.usuario = RepoUsuarios.instance.searchById(usuario.id)
		this.carrito = newArrayList
//		this.carritoRedis = CarritoRedis.instance
		this.peliculas = repoPeliculas.allInstances
		this.jedisPool = new JedisPool(new JedisPoolConfig, Constants.LOCALHOST)
	}

	def buscar() {
		busquedaActual = busquedaIngresada
		ObservableUtils.firePropertyChanged(this, "peliculas")
	}

	def List <Pelicula> getPeliculas() {
		if (StringUtils.isBlank(busquedaActual)) {
			repoPeliculas.allInstances
		} else {
			repoPeliculas.allInstances.filter[tieneValorBuscado(busquedaActual)].toList
		}
	}

	def getRecomendadas() {
		return repoPeliculas.searchByExample(new Pelicula)
	}

	def agregarAlCarrito() {
		carrito.add(this.getNewEntrada)
//		carritoRedis.agregar(this.getNewEntrada)
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
	}

	def sacarDelCarrito() {
		carrito.remove(funcionCarritoSeleccionada)
//		carritoRedis.eliminar(funcionCarritoSeleccionada)
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "carrito")
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
		ObservableUtils.firePropertyChanged(this, "totalPrecioCarrito")
	}

	def limpiarCarrito() {
		carrito.clear
//		carritoRedis.limpiar
		this.mensajeError = ""
		ObservableUtils.firePropertyChanged(this, "carrito")
		ObservableUtils.firePropertyChanged(this, "cantidadItems")
		ObservableUtils.firePropertyChanged(this, "totalPrecioCarrito")
	}

	def comprar() {
		if(this.totalPrecioCarrito > usuario.saldo) throw new UserException(
			"ERROR no tiene saldo para realizar la compra")
		carrito.forEach[funcion|usuario.comprarEntrada(funcion)]
//		carritoRedis.forEach[funcion|usuario.comprarEntrada(funcion)]
		limpiarCarrito
	}

	@Dependencies("peliculaSeleccionado", "funcionSeleccionada")
	def getValidarFuncion() {
		peliculaSeleccionado !== null && funcionSeleccionada !== null
	}

	def getCantidadItems() {
		this.carrito.size
//		this.carritoRedis.cantidadItems.intValue
	}

	def getFechaActual() {
		formatterDate.format(LocalDate.now)
	}

	def getPrecioEntrada() {
		return getNewEntrada().precio
	}

	@Dependencies("funcionSeleccionada")
	def Entrada getNewEntrada() {
		new Entrada(peliculaSeleccionado, funcionSeleccionada)
	}

	def getTotalPrecioCarrito() {
//		for (var i=0; i<carritoRedis.cantidadItems;i++){
//			
//		}
		
		
		this.carrito.fold(0d, [total, entrada|total + entrada.precio])
	}

	def getPeliculaSeleccionado() {
		if(this.peliculaSeleccionado !== null){
			repoPeliculas.searchById(this.peliculaSeleccionado.id)
		}
	}

	def repoPeliculas() {
		RepoPeliculasMongoDB.instance
	}
	
	def getValidarCarrito() {
		if(cantidadItems < 1) throw new UserException("Debe agregar entradas al carrito para avanzar")
//		if(this.carritoRedis.cantidadItems < 1) throw new UserException("Debe agregar entradas al carrito para avanzar")
	}
	
//	def boolean operator_lessThan(Function1<Jedis, Long> function1, int i)
//	def boolean operator_lessThan(int i, Function1<Jedis, Long> function1)
//	def int getIntValue(Function1<Jedis, Long> function1)
}
