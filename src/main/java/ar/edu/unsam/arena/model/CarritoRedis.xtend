package ar.edu.unsam.arena.model

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.funcion.Funcion
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import redis.clients.jedis.Jedis
import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig

@Observable
@Accessors
class CarritoRedis {
//	List<Entrada> entradas = newArrayList
	var JedisPool jedisPool
	static CarritoRedis instance = null
	String carrito = "carrito"

	private new() {
		jedisPool = new JedisPool(new JedisPoolConfig, Constants.LOCALHOST)
	}

	static def getInstance() {
		if (instance === null) {
			instance = new CarritoRedis
		}
		instance
	}
		
	def agregar(Entrada entrada) {
		return [Jedis jedis|jedis.rpush(carrito, entrada.toString)]
	}
	
	def eliminar(Funcion funcion) {
		return [Jedis jedis|jedis.del(funcion.toString)]
	}
	
	def limpiar() {
		return [Jedis jedis|jedis.del(carrito)]
	}
	
	def int cantidadItems() {
		return [Jedis jedis|jedis.llen(carrito)]
	}
}