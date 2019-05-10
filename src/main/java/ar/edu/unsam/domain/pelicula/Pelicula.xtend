package ar.edu.unsam.domain.pelicula

import ar.edu.unsam.domain.funcion.Funcion
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.FetchType
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import org.apache.commons.lang.StringUtils
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Inheritance(strategy=InheritanceType.JOINED)
@Accessors
class Pelicula {

	@Id	ObjectId id
	
//	@Column(length=100)
	String titulo
	
//	@Column
	float puntaje
	
//	@Column(length=100)
	String genero
	
//	@OneToMany (fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Set<Funcion> funciones = newHashSet
	
//	@Column
	double precioBase = 30.00 //contemplar bigdecimal
	
//	@Column
	int anio

	new() {		}

	new(int anio,String titulo, float puntaje, String genero) {
		this.titulo = titulo
		this.anio = anio
		this.puntaje = puntaje
		this.genero = genero
		this.precioBase = 30.00
	}
	
	new(int anio,String titulo, float puntaje, String genero, Set<Funcion> funciones) {
		this.titulo = titulo
		this.anio = anio
		this.puntaje = puntaje
		this.genero = genero
		this.funciones = funciones
		this.precioBase = 30.00
	}
	
	def double getPrecioEntrada() {
		this.precioBase
	}

	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
}
