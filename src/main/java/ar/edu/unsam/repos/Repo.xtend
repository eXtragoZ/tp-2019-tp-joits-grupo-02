package ar.edu.unsam.repos

import java.util.List;

interface Repo<T> {

	def Class<T> getEntityType()

	def T searchById(long id)
	
	def T searchByString(String valor)

	def List<T> searchByExample(T example)

	def T createExample()

	def List<T> allInstances()

	def void create(T object)

	def void update(T object)

	def void delete(T object)

}
