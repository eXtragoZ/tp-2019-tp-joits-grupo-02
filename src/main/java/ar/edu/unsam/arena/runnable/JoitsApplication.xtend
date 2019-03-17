package ar.edu.unsam.arena.runnable
import org.uqbar.arena.Application
import ar.edu.unsam.arena.view.LoginView
import ar.edu.unsam.arena.model.LoginModel

class JoitsApplication extends Application {
	new(JoitsBootstrap bootstrap) {
		super(bootstrap)
	}
	
	def static main(String[] args) {
		new JoitsApplication(new JoitsBootstrap).start
	}
	
	override protected createMainWindow() {
		new LoginView(this, new LoginModel)
	}
	
}