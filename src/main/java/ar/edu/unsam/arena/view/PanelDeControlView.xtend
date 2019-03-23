package ar.edu.unsam.arena.view

import ar.edu.unsam.arena.model.PanelDeControlModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
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
			layout = new VerticalLayout
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it) => [
					text = "Usuario"
					width = 100
					alignLeft
				]
				new Label(it) => [
					value <=> "usuario.userName"
					width = 100
					alignLeft
				]
			]
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it) => [
					text = "Edad"
					width = 100
					alignLeft
				]
				new TextBox(it) => [
					value <=> "usuario.edad"
					width = 100
				]
				
			]
		]
	}
	
}
