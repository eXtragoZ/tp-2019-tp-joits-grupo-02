package ar.edu.unsam.repos

import ar.edu.unsam.domain.funcion.Funcion
import ar.edu.unsam.domain.pelicula.Pelicula
import com.mongodb.MongoClient
import java.time.LocalDateTime
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.aggregation.Accumulator
import org.mongodb.morphia.aggregation.Group
import org.mongodb.morphia.query.UpdateOperations
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class RepoPeliculasMongoDB {

	static protected Datastore ds

	static RepoPeliculasMongoDB instance

	new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 28001)
			new Morphia => [
				map(Pelicula).map(Funcion)
				ds = createDatastore(mongo, "Pelicula")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasMongoDB
		} else {
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
		ds.createQuery(entityType).field("titulo").contains(example.titulo ?: "").asList
	}

	def Pelicula searchById(ObjectId id) {
		ds.createQuery(entityType).field("id").equal(id).asList.head
	}

	def Pelicula createIfNotExists(Pelicula pelicula) {
		val entidadAModificar = getByExample(pelicula)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		create(pelicula)
	}

	def void update(Pelicula pelicula) {
		ds.merge(pelicula)
//		ds.update(pelicula, this.defineUpdateOperations(pelicula))
	}

	def UpdateOperations<Pelicula> defineUpdateOperations(Pelicula pelicula) {
		ds.createUpdateOperations(entityType).set("titulo", pelicula.titulo).set("puntaje", pelicula.puntaje).set(
			"genero", pelicula.genero).set("funciones", pelicula.funciones).set("precioBase", pelicula.precioBase).set(
			"anio", pelicula.anio)
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

	def peliculasDeSala(String sala) {
		// db.getCollection('Pelicula').find({ "funciones.nombreSala": "Sala B" }).pretty()
		ds.createQuery(Pelicula).filter("funciones.nombreSala =", sala).asList
	}

	def peliculasDeAnioEnMasDeUnaSala(int anio) {
		/*
		 * db.Pelicula.aggregate([
		 *     { $match: { anio: 2019 } },
		 *     { $unwind: "$funciones" },
		 *     { $group: { _id: { _id: "$_id", sala: "$funciones.nombreSala" } } },
		 *     { $group: { _id: "$_id._id", salas: { $sum: 1 } } },
		 *     { $match: { salas: { $gte: 2 } } },
		 *     { $count: 'Cantidad de Peliculas' }
		 *])
		 */
		 
		 ds.createAggregation(Pelicula)
		 	.match(ds.createQuery(Pelicula).filter("anio =", anio))
			.unwind("funciones")
			.group(
				newArrayList(Group.grouping("_id", "_id"), Group.grouping("sala", "funciones.nombreSala"))
			)
			.group(
				"_id._id",
				Group.grouping("cantidad", Accumulator.accumulator("$sum", 1))
			)
			.match(ds.createQuery(Cantidad).filter("cantidad >=", 2))
			.group(Group.grouping("cantidad", Accumulator.accumulator("$sum", 1)))
			.aggregate(RepoPeliculasMongoDB.Cantidad)
			.toList.get(0).cantidad
			
	}

	static class Cantidad {
		int cantidad
	}
	
	def peliculasConFuncionDesdeFecha(LocalDateTime fecha) {
		/*
		 *  db.getCollection('Pelicula').aggregate([
		 *  { $unwind: "$funciones" },
		 *  { $match : { "funciones.fechaHora" : {$gte:ISODate("2019-05-25T22:02:04.493Z")}} },
		 *  { $group: {
		 *    _id: "$_id",
		 *    titulo: { "$first":"$titulo"},
		 *    puntaje:{ "$first":"$puntaje"}, 
		 *    genero:{ "$first":"$genero"}, 
		 *    anio: { "$first":"$anio"},
		 *    className: { "$first":"$className"}
		 *  }}
		 * ])
		 */
		ds.createAggregation(Pelicula)
			.unwind("funciones")
			.match(ds.createQuery(Pelicula).filter("funciones.fechaHora >=", fecha))
			.group(
				"_id",
				Group.grouping("titulo", Group.first("titulo")),
				Group.grouping("puntaje", Group.first("puntaje")),
				Group.grouping("genero", Group.first("genero")),
				Group.grouping("anio", Group.first("anio"))
			)
			.aggregate(Pelicula)
			.toList
	}

}
