package ar.edu.unsam.funcion
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Funcion {
	
	Date fechaFuncion
	int horaFuncion
	String nombreSala
	
}