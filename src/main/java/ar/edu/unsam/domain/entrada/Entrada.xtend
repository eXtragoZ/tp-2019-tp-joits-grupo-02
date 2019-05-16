package ar.edu.unsam.domain.entrada

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Transient

@Entity
@Observable
@Accessors
class Entrada {

	@Id
	@GeneratedValue
	long id

	@Column
	LocalDateTime fechaHora
	
	@Column
	Double precio
	
	@Column
	String tituloPelicula

	@Transient //OneToOne(fetch=FetchType.LAZY)
	Pelicula pelicula

	@Transient//OneToOne(fetch=FetchType.LAZY)
	Funcion funcion

	new() {	}

	new(Pelicula pelicula) {
		this.fechaHora = LocalDateTime.now
		this.pelicula = pelicula
		this.precio = pelicula.precioEntrada + funcion.precio
		this.tituloPelicula = pelicula.titulo
	}

	new(Pelicula pelicula, Funcion funcion) {
		this.fechaHora = LocalDateTime.now
		this.pelicula = pelicula
		this.funcion = funcion
		this.precio = pelicula.precioEntrada + funcion.precio
		this.tituloPelicula = pelicula.titulo
	}

}
