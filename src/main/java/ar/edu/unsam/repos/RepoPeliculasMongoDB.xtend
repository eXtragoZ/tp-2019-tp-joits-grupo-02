package ar.edu.unsam.repos

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import com.mongodb.MongoClient
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class RepoPeliculasMongoDB {
	
	static protected Datastore ds
	
	static RepoPeliculasMongoDB instance
	
	new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 27017)
			new Morphia => [
				map(Pelicula).map(Funcion)
				ds = createDatastore(mongo, "test")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	def static getInstance(){
		if(instance === null){
			instance = new RepoPeliculasMongoDB
		}else {
			instance
		}
	}
	
	def Pelicula getByExample(Pelicula example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}

	def List<Pelicula> searchByExample(Pelicula example) {
		ds.createQuery(entityType)
			.field("titulo").contains(example.titulo ?: "")
//			.field("activo").equal(true)
//			.field("estado").equal(example.estado ?: Libro.DISPONIBLE)
			.asList
	}
	
	def Pelicula searchById(ObjectId id) {
		ds.createQuery(entityType)
			.field("id").equal(id)
//			.field("activo").equal(true)
//			.field("estado").equal(example.estado ?: Libro.DISPONIBLE)
			.asList.head
	}

	def Pelicula createIfNotExists(Pelicula pelicula) {
		val entidadAModificar = getByExample(pelicula)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		create(pelicula)
	}

	def void update(Pelicula pelicula) {
		ds.update(pelicula, this.defineUpdateOperations(pelicula))
	}

	def UpdateOperations<Pelicula> defineUpdateOperations(Pelicula pelicula) {
		ds.createUpdateOperations(entityType)
			.set("titulo", pelicula.titulo)
			.set("puntaje", pelicula.puntaje)
			.set("genero", pelicula.genero)
			.set("funciones", pelicula.funciones) 	
			.set("precioBase", pelicula.precioBase)
			.set("anio", pelicula.anio)
	}

	def Pelicula create(Pelicula pelicula) {
		ds.save(pelicula)
		pelicula
	}

	def void delete(Pelicula pelicula) {
		ds.delete(pelicula)
	}

	def List<Pelicula> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	def Class<Pelicula> getEntityType() {
		Pelicula
	}

}