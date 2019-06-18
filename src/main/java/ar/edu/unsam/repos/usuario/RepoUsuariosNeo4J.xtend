package ar.edu.unsam.repos.usuario

import ar.edu.unsam.domain.usuario.Usuario
import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.config.Configuration
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.session.SessionFactory

class RepoUsuariosNeo4J {
	
		/**
	 * Al buscar muchos elementos, buscaremos por defecto traer solo la información de ese nodo, por eso 0.
	 * Al buscar un nodo concreto, la profundidad será 1 para traer el nodo y sus relaciones
	 */
	public static int PROFUNDIDAD_BUSQUEDA_LISTA = 0
	public static int PROFUNDIDAD_BUSQUEDA_CONCRETA = 1

	/**
	 * http://neo4j.com/docs/ogm-manual/current/reference/
	 * 
	 */
	static Configuration configuration = new Configuration.Builder().uri("bolt://localhost:11005").credentials("neo4j",
		"joits").build()

	public static SessionFactory sessionFactory = new SessionFactory(configuration,
		"ar.edu.unsam.domain")

	protected def getSession() {
		sessionFactory.openSession
	}

	def createOrUpdate(Usuario usuario) {
		session.save(usuario)
	}

	def List<Usuario> getNoAmigos(String valor) {
		val filtroPorNombreActor = 
			new Filter("name", ComparisonOperator.MATCHES, "(?i).*" + valor + ".*")
		return new ArrayList(session.loadAll(typeof(Usuario), filtroPorNombreActor, PROFUNDIDAD_BUSQUEDA_LISTA))
	}

//	def Filters filtroUsuarios(Busqueda usuarioBusqueda) {
//		// Construyo un filtro que no filtra, para que filtroUsuarios devuelva siempre Filters
//		var filtroTrue = new Filter("nombreUsuario", ComparisonOperator.MATCHES, ".*")
//		val filtroPorNombreUsuario = new Filter("nombreUsuario", ComparisonOperator.MATCHES,
//			".*(?i)" + usuarioBusqueda.valorABuscar + ".*")
//		val filtrarPo = new Filter("apellido", ComparisonOperator.EQUALS, usuarioBusqueda.anioABuscar)
//		if (usuarioBusqueda.filtraPorAnio) {
//			// Solo busca por año
//			if (!usuarioBusqueda.seleccionoConector) {
//				return filtroPorApellido.and(filtroTrue)
//			}
//			if (usuarioBusqueda.hasAnd) {
//				return filtroPorNombreUsuario.and(filtroPorApellido)
//			}
//			if (usuarioBusqueda.hasOr) {
//				return filtroPorNombreUsuario.or(filtroPorApellido)
//			}
//		}
//		filtroPorNombreUsuario.and(filtroTrue)
//	}

	def Usuario getUsuario(Long id) {
		session.load(typeof(Usuario), id, PROFUNDIDAD_BUSQUEDA_CONCRETA)
	}

	/**
	 * Contra, tuve que agregar el eliminarPersonaje porque la actualización en cascada
	 * no detectó la ausencia de una relación, quizás por la forma en que está configurada
	 */
//	def void eliminarPersonaje(Personaje personaje) {
//		session.delete(personaje)
//	}

	def void actualizarUsuario(Usuario usuario) {
//		usuario.validar
		session.save(usuario)
	// ver save(entity, depth). Aquí por defecto depth es -1 que
	// implica hacer una pasada recorriendo todo el grafo en profundidad
	}

}
