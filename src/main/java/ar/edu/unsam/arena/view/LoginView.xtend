package ar.edu.unsam.arena.view

import org.uqbar.arena.windows.Window
import ar.edu.unsam.arena.model.LoginModel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.HorizontalLayout

class LoginView extends Window<LoginModel> {
	
	new(WindowOwner owner, LoginModel model) {
		super(owner, model)
		this.title = "Joits - Loguin"
	}
	
	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new VerticalLayout
			agregarValorEditable("Usuario", "usuario")
			agregarValorEditable("Password", "password")
			agregarAcciones
		]
	}
	def void agregarAcciones(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Button(it) => [
				caption = "Cancelar"
				onClick [this.close]
			]
			new Button(it) => [
				caption = "Aceptar"
				onClick [this.aceptar]
				enabled <=> "validar"
			]
			
			

		]
			
	}
	
	
	def void agregarValorEditable(Panel panel, String descripcion, String valor) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it) => [
				text = descripcion
				width = 100
				alignLeft
			]
			new TextBox(it) => [
				value <=> valor
				width = 200
				alignLeft
			]
		]
	}
	
	def aceptar() {
		println(modelObject.usuario)
	}
}