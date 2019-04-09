package ar.edu.unsam.domain.rodaje

import ar.edu.unsam.domain.funcion.Funcion
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Inheritance(strategy=InheritanceType.JOINED)
@Accessors
class Rodaje {

	@Id	@GeneratedValue
	Long id
	
	@Column(length=100)
	String titulo
	
	@Column
	float puntaje
	
	@Column(length=100)
	String genero
	
	@OneToMany (fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Funcion> funciones = newArrayList
	
	@Column
	double precioBase = 30.00
	
	@Column
	int anio

	new() {		}

	new(int anio,String titulo, float puntaje, String genero) {
		this.titulo = titulo
		this.anio = anio
		this.puntaje = puntaje
		this.genero = genero
		this.precioBase = 30.00
	}
	
	new(int anio,String titulo, float puntaje, String genero, List<Funcion> funciones) {
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
