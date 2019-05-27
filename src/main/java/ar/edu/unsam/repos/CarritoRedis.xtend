package ar.edu.unsam.repos

import ar.edu.unsam.domain.entrada.Entrada
import ar.edu.unsam.domain.usuario.Usuario
import com.fasterxml.jackson.databind.ObjectMapper
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig
import com.fasterxml.jackson.databind.DeserializationFeature

@Observable
@Accessors
class CarritoRedis {
	val objectMapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
	var JedisPool jedisPool
	static CarritoRedis instance = null

	private new() {
		jedisPool = new JedisPool(new JedisPoolConfig, Constants.LOCALHOST)
	}

	static def getInstance() {
		if (instance === null) {
			instance = new CarritoRedis
		}
		instance
	}

	def getCarritoKey(Usuario usuario) {
		Constants.CARRITO + Constants.SEPARADOR + usuario.nombreUsuario
	}

	def obtener(Usuario usuario) {
		jedisPool.resource.lrange(getCarritoKey(usuario), 0, -1).map[objectMapper.readValue(it, Entrada)]
	}

	def agregar(Usuario usuario, Entrada entrada) {
		jedisPool.resource.rpush(getCarritoKey(usuario), objectMapper.writeValueAsString(entrada))
	}

	def eliminar(Usuario usuario, Entrada entrada) {
		jedisPool.resource.lrem(getCarritoKey(usuario), 1, objectMapper.writeValueAsString(entrada))
	}

	def limpiar(Usuario usuario) {
		jedisPool.resource.del(getCarritoKey(usuario))
	}

	def getCantidadItems(Usuario usuario) {
		jedisPool.resource.llen(getCarritoKey(usuario))
	}
}
