package ar.edu.unsam.arena.view

import ar.edu.unsam.arena.model.PanelDeControlModel
import ar.edu.unsam.entrada.Entrada
import ar.edu.unsam.usuario.Usuario
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PanelDeControlView extends Window<PanelDeControlModel> {

	new(WindowOwner owner, PanelDeControlModel model) {
		super(owner, model)
		this.title = "Joits - Panel de Control"
	}

	override createContents(Panel mainPanel) {
		mainPanel => [

			layout = new HorizontalLayout
			
			panelIzquierdo(it)
			panelDerecho(it)
		]

	}
	
	private def Panel panelDerecho(Container it) {
		new Panel(it) => [
			
			layout = new VerticalLayout
			
			labelDoble(it, "Saldo", "usuario.saldo")
			
			new Panel(it) => [
				new HorizontalLayout
				labelAndButton(it, "Cargar Saldo", "saldoNuevo")
				new Button(it) => [
					caption = "Cargar"
				]
			]
			
			new Table<Entrada>(it, typeof(Entrada)) => [
				items <=> "usuario.entradas"
				numberVisibleRows = 6
		
				new Column<Entrada>(it) => [
					title = "Titulo"
					bindContentsToProperty("tituloRodaje")
					fixedSize = 150
				]
			]
		
			new Panel(it) => [
				layout = new HorizontalLayout
				new Button(it) => [
					caption = "Aceptar"
				]
				new Button(it) => [
					caption = "Cancelar"
				]
			]
		
		]
	}

	private def Panel panelIzquierdo(Panel it) {
		new Panel(it) => [

			layout = new VerticalLayout
			
			labelDoble(it, "Usuario", "usuario.userName")
			labelAndButton(it, "Edad", "usuario.edad")

			new Panel(it) => [

				layout = new VerticalLayout
				new Table<Usuario>(it, typeof(Usuario)) => [
					items <=> "usuario.amigos"
					numberVisibleRows = 6

					new Column<Usuario>(it) => [
						title = "Nombre"
						bindContentsToProperty("nombre")
						fixedSize = 150
					]
					new Column<Usuario>(it) => [
						title = "Fecha"
						bindContentsToProperty("apellido")
						fixedSize = 40
					]
				]

			]

			new Button(it) => [
				caption = "Buscar Amigos"
			]
		]
	}

	private def Panel labelAndButton(Container it, String unLabel, String unButton) {
		new Panel(it) => [
			layout = new HorizontalLayout
			new Label(it) => [
				text = unLabel
				width = 100
				alignLeft
			]
			new TextBox(it) => [
				value <=> unButton
				width = 100
			]

		]
	}

	private def Panel labelDoble(Container it, String unLabel, String otroLabel) {
		new Panel(it) => [
			layout = new HorizontalLayout
			new Label(it) => [
				text = unLabel
				width = 100
				alignLeft
			]
			new Label(it) => [
				text = otroLabel
				width = 100
				alignLeft
			]
		]
	}

}
