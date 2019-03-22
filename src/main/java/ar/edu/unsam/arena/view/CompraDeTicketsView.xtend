package ar.edu.unsam.arena.view

import ar.edu.unsam.arena.model.CompraDeTicketsModel
import ar.edu.unsam.funcion.Funcion
import ar.edu.unsam.rodaje.Pelicula
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CompraDeTicketsView extends Window<CompraDeTicketsModel> {

	new(WindowOwner owner, CompraDeTicketsModel model) {
		super(owner, model)
		this.title = "Joits - Compra de Tickets"
	}

	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new VerticalLayout
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it) => [
					text = "Usuario Logueado: ??????"
					width = 300
					alignLeft
				]
				new Label(it) => [
					text = "Fecha 00/00/0000"
					width = 300
					alignRight
				]
			]
			new Panel(it) => [
				layout = new HorizontalLayout
				agregarPanelPeliculas()
				agregarPanelFunciones()
			]
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it) => [
					text = "Items en carrito: ??????"
				]
				new Button(it) => [
					caption = "Finalizar compra"
				]
				new Label(it) => [
					width = 300
				]
				new Button(it) => [
					caption = "Panel de Control"
				]
			]

		]
	}

	def void agregarPanelPeliculas(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			agregarBuscador()
			agregarListaPeliculas("peliculas")
			new Label(it) => [
				text = "Pelis recomendadas"
				width = 100
				alignLeft
			]
			agregarListaPeliculas("peliculasRecomendadas")
		]
	}

	def void agregarPanelFunciones(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new Label(it) => [
				text = "Funciones"
				width = 100
				alignLeft
			]
			agregarListaFunciones()
			new Label(it) => [
				text = "Importe de la entrada seleccionada: $???"
				width = 100
				alignLeft
			]
			new Button(it) => [
				caption = "Agregar al carrito"
				onClick [this.modelObject.agregarAlCarrito]
				enabled <=> "validarFuncion"
			]
		]
	}

	def void agregarBuscador(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new TextBox(it) => [
				value <=> "busquedaIngresada"
				width = 250
			]
			new Button(it) => [
				caption = "Buscar"
				onClick[this.modelObject.buscar]
				setAsDefault
			]
		]
	}

	def agregarListaPeliculas(Panel panel, String lista) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new Table<Pelicula>(it, typeof(Pelicula)) => [
				items <=> lista
				value <=> "rodajeSeleccionado"
				numberVisibleRows = 6
				
				new Column<Pelicula>(it) => [
					title = "Nombre"
					bindContentsToProperty("titulo")
					fixedSize = 150
				]
				new Column<Pelicula>(it) => [
					title = "Fecha"
					bindContentsToProperty("anio")
					fixedSize = 40
				]
				new Column<Pelicula>(it) => [
					title = "Rating"
					bindContentsToProperty("puntaje")
					fixedSize = 30
				]
				new Column<Pelicula>(it) => [
					title = "Género"
					bindContentsToProperty("genero")
					fixedSize = 100
				]
			]

		]
	}

	def agregarListaFunciones(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new Table<Funcion>(it, typeof(Funcion)) => [
				items <=> "rodajeSeleccionado.funciones"
				value <=> "funcionSeleccionada"
				numberVisibleRows = 9
				new Column<Funcion>(it) => [
					title = "Fecha"
					bindContentsToProperty("fecha")
					fixedSize = 100
				]
				new Column<Funcion>(it) => [
					title = "Hora"
					bindContentsToProperty("hora")
					fixedSize = 50
				]

				new Column<Funcion>(it) => [
					title = "Sala"
					bindContentsToProperty("nombreSala")
					fixedSize = 100
				]
			]

		]
	}
}
