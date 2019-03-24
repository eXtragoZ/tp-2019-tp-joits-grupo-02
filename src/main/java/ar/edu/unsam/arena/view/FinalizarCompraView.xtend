package ar.edu.unsam.arena.view

import ar.edu.unsam.arena.model.CompraDeTicketsModel
import ar.edu.unsam.funcion.Funcion
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.bindings.NotNullObservable

class FinalizarCompraView extends Window<CompraDeTicketsModel> {

	new(WindowOwner owner, CompraDeTicketsModel model) {
		super(owner, model)
		this.title = "Joits - Finalizar Compra"
	}

	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new VerticalLayout
			new Label(it) => [
				text = "Pelis en el carrito"
				alignLeft
			]
			agregarListaCarrito

			new Panel(it) => [
				layout = new HorizontalLayout
				new Button(it) => [
					caption = "Eliminar Item"
					onClick [this.modelObject.sacarDelCarrito]
					bindEnabled(new NotNullObservable("funcionCarritoSeleccionada"))
				]
				new Label(it) => [
					width = 390
				]
				new Label(it) => [
					text = "Total: $"
				]
				new Label(it) => [
					value <=> "totalPrecioCarrito"
				]
				
			]

			new Panel(it) => [
				layout = new HorizontalLayout
				new Button(it) => [
					caption = "Limpiar carrito"
					onClick [this.modelObject.limpiarCarrito]
				]
				new Label(it) => [
					width = 320
				]
				new Button(it) => [
					caption = "Comprar"
					onClick [
						this.modelObject.comprar
						this.close
					]
				]
				new Button(it) => [
					caption = "Volver atrás"
					onClick [this.close]
				]
			]

		]
	}

	def agregarListaCarrito(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new Table<Funcion>(it, typeof(Funcion)) => [
				items <=> "carrito"
				value <=> "funcionCarritoSeleccionada"
				numberVisibleRows = 6

				new Column<Funcion>(it) => [
					title = "Nombre"
					bindContentsToProperty("rodaje.titulo")
					fixedSize = 200
				]
				new Column<Funcion>(it) => [
					title = "Rating"
					bindContentsToProperty("rodaje.puntaje")
					fixedSize = 60
				]
				new Column<Funcion>(it) => [
					title = "Género"
					bindContentsToProperty("rodaje.genero")
					fixedSize = 100
				]
				new Column<Funcion>(it) => [
					title = "Fecha y Hora"
					bindContentsToProperty("fechaHora")
					fixedSize = 120
				]
				new Column<Funcion>(it) => [
					title = "Precio"
					bindContentsToProperty("precio")
					fixedSize = 60
				]
			]

		]
	}
}
