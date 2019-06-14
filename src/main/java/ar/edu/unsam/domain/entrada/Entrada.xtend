package ar.edu.unsam.domain.entrada

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import ar.edu.unsam.domain.usuario.Usuario
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
import org.neo4j.ogm.annotation.EndNode
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.RelationshipEntity
import org.neo4j.ogm.annotation.StartNode
import org.uqbar.commons.model.annotations.Observable

@RelationshipEntity(type="MOVIES_SEEING")
@Entity
@Observable
@Accessors
@JsonInclude(Include.NON_NULL)
@JsonIgnoreProperties(value = "changeSupport")
class Entrada {

	@Id
	@org.neo4j.ogm.annotation.Id @org.neo4j.ogm.annotation.GeneratedValue
	Long id
		
	@Property
	@Column
	@JsonSerialize(using = LocalDateTimeSerializer)
	@JsonDeserialize(using = LocalDateTimeDeserializer)
	LocalDateTime fechaHora
	
	@Property
	@Column
	Double precio
	
	@Property(name="titulo")
	@Column
	String tituloPelicula

	@EndNode
	@Transient
//	@Property(name="pelicula")
	@JsonIgnore
	Pelicula pelicula

	@StartNode 
	@Transient
	Usuario usuario
	
	@JsonIgnore
	transient Funcion funcion

	new() {	}

	new(Pelicula pelicula, Funcion funcion) {
		this.fechaHora = LocalDateTime.now
		this.pelicula = pelicula
		this.funcion = funcion
		this.precio = pelicula.precioEntrada + funcion.precio
		this.tituloPelicula = pelicula.titulo
	}
	
	new(Pelicula pelicula, Funcion funcion, Usuario usuario) {
		this.fechaHora = LocalDateTime.now
		this.pelicula = pelicula
		this.funcion = funcion
		this.usuario = usuario
		this.precio = pelicula.precioEntrada + funcion.precio
		this.tituloPelicula = pelicula.titulo
	}
	
	
	@JsonIgnore
	def getFechaHoraFormatted() {
		val formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")
		formatterDateTime.format(fechaHora)
	}

}
