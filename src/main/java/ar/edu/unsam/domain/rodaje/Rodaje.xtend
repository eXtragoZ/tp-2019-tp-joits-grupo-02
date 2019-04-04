package ar.edu.unsam.domain.rodaje

import ar.edu.unsam.domain.funcion.Funcion
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

//usar inherits del taller de politics
@Entity
@Observable
@Accessors
abstract class Rodaje {

	@Id
	@GeneratedValue
	long id
	
	@Column(length=100)
	String titulo
	
	@Column
	float puntaje
	
	@Column(length=100)
	String genero
	
	@OneToMany (fetch=FetchType.LAZY)
	List<Funcion> funciones = newArrayList
	
	@Column
	double precioBase = 30.00
	
	@Column
	int anio

	new() {
		super()
	}

	new(String titulo, int anio, float puntaje, String genero) {
		this.titulo = titulo
		this.anio = anio
		this.puntaje = puntaje
		this.genero = genero
	}

	def double getPrecioEntrada() {
		this.precioBase
	}

	def tieneValorBuscado(String valorBusqueda) {
		return StringUtils.containsIgnoreCase(titulo, valorBusqueda)
	}
}
