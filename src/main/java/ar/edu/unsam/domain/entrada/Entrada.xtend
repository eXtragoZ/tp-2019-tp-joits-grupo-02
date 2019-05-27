package ar.edu.unsam.domain.entrada

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import com.fasterxml.jackson.databind.annotation.JsonDeserialize
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer
import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.annotation.JsonInclude.Include
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.time.format.DateTimeFormatter
import com.fasterxml.jackson.annotation.JsonIgnore

@Entity
@Observable
@Accessors
@JsonInclude(Include.NON_NULL)
@JsonIgnoreProperties(value = "changeSupport")
class Entrada {

	@Id
	@GeneratedValue
	long id

	@Column
	@JsonSerialize(using = LocalDateTimeSerializer)
	@JsonDeserialize(using = LocalDateTimeDeserializer)
	LocalDateTime fechaHora
	
	@Column
	Double precio
	
	@Column
	String tituloPelicula

	//OneToOne(fetch=FetchType.LAZY)
	//transient Pelicula pelicula

	//OneToOne(fetch=FetchType.LAZY)
	//transient Funcion funcion

	new() {	}

	new(Pelicula pelicula, Funcion funcion) {
		this.fechaHora = LocalDateTime.now
		//this.pelicula = pelicula
		//this.funcion = funcion
		this.precio = pelicula.precioEntrada + funcion.precio
		this.tituloPelicula = pelicula.titulo
	}
	
	@JsonIgnore
	def getFechaHoraFormatted() {
		val formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
		formatterDateTime.format(fechaHora)
	}

}
