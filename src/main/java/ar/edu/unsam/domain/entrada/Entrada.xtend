package ar.edu.unsam.domain.entrada

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.annotation.JsonInclude.Include
import com.fasterxml.jackson.databind.annotation.JsonDeserialize
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable

@NodeEntity(label="Entrada")
@Entity
@Observable
@Accessors
@JsonInclude(Include.NON_NULL)
@JsonIgnoreProperties(value = "changeSupport")
class Entrada {

	@Id @GeneratedValue
	@org.neo4j.ogm.annotation.Id @org.neo4j.ogm.annotation.GeneratedValue
	long id
	
	@Property(name="fecha")
	@Column
	@JsonSerialize(using = LocalDateTimeSerializer)
	@JsonDeserialize(using = LocalDateTimeDeserializer)
	LocalDateTime fechaHora
	
	@Property(name="precio")
	@Column
	Double precio
	
	@Property(name="titulo")
	@Column
	String tituloPelicula

	@Relationship(type = "MOVIE", direction = "INCOMING")
	@Transient
	@Property(name="pelicula")
	@JsonIgnore
	Pelicula pelicula

	@Relationship(type = "FUNCTION", direction = "INCOMING")
	@Transient
	@Property(name="funcion")
	@JsonIgnore
	Funcion funcion

	new() {	}

	new(Pelicula pelicula, Funcion funcion) {
		this.fechaHora = LocalDateTime.now
		this.pelicula = pelicula
		this.funcion = funcion
		this.precio = pelicula.precioEntrada + funcion.precio
		this.tituloPelicula = pelicula.titulo
	}
	
	@JsonIgnore
	def getFechaHoraFormatted() {
		val formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
		formatterDateTime.format(fechaHora)
	}

}
