file = File.open('alumnos.csv','r')
data = file.readlines #Para guardar cada línea en un elemento separado en una matriz
data = data.map{ | element | element.split(',').map(&:strip) } #Quitamos las comas y puntos
file.close #Cerramos el archivo

########################################## Inicio Metodos ##########################################
def add_file(data)
	suma=0
	num_nota=0
	if File.exist?("promedio.csv")
		puts "El archivo existe!!!! El mismo se sobreescribirá"
	end
		f = File.open('promedio.csv', 'w')
		f.puts ("Los promedios de los alumnos en curso son:")
		data.each do |alumno|
			num_nota = alumno.length-1.to_i
			promedio = alumno.inject(0) {|nota, n| nota.to_f + n.to_f }.to_f / num_nota
			puts "El promedio para #{alumno[0]} #{promedio}"
			f.puts ("El promedio para #{alumno[0]} #{promedio}")
		end
	f.close
	puts "Generado con exito!!! \n"
	puts "Se guardo en la siguiente ruta: /pruebaruby/promedio.cvs \n"
	puts "** Presione ** Enter ** para continuar \n"
end

def cant_absences(data)
	inasistencia = "A"
	total = 0
	data.each do | element |
		 ocurrencias = element.count { |x| x == inasistencia }
		 total += ocurrencias
	end
	puts "El total de inasistencias del curso es: #{total} \n"
	puts "** Presione ** Enter ** para continuar \n"
end

def alumnos_aprobados(nota)

	data = leer_archivo()
	
	data.each do |alumno|
			num_nota = alumno.length-1.to_i
			promedio = alumno.inject(0) {|nota, n| nota.to_f + n.to_f }.to_f / num_nota
			if promedio.to_f > nota.to_f  
				puts "El alumno #{alumno[0]} obtuvo un de #{promedio}"
			end
	end
	puts "** Presione ** Enter ** para continuar \n"
end

def leer_archivo()
	file = File.open('alumnos.csv','r')
	data = file.readlines #Para guardar cada línea en un elemento separado en una matriz
	data = data.map{ | element | element.split(',').map(&:strip) } #Quitamos las comas y puntos
	file.close #Cerramos el archivo	
	return data
end

def system_out()
		puts '***********************************************************************************'
		puts '******************★ ★ ★ Vuelve Pronto!!!! ★ ★ ★************************************'
		puts '***********************************************************************************'
end

########################################## Fin Metodos ##########################################


########################################## Inicio Menu ##########################################

puts '***********************************************************************************'
puts '******************★ ★ ★ Sistema de Control de Notas ★ ★ ★**************************'
puts '***********************************************************************************'
	puts '************ Presione **Enter** para comenzar ************ :D '

	option = gets.chomp

	while option != '4'
		
		option = gets.chomp
		puts '****** Opción 1: Generar un archivo con el nombre de cada alumno'
		puts '****** Opción 2: Cantidad total de Inasistencias'
		puts '****** Opción 3: Alumnos aprobados'
		puts '****** Opción 4: Salir del Sistema'
		
		option = gets.chomp

		puts case  option
			when '1' #Permite generar un archivo con los nombres de cada alumno 
				add_file(data)
			when '2' #Opción 2: Indica la Cantidad total de inasistencia.
				cant_absences(data)
			when '3' #Opción 4: Alumnos Aprobados
				puts '** ¿ Desea ingresar una nota mínima para aprabar S/N ? **'
				option_nota = gets.chomp.capitalize
				if option_nota == "S"
					puts "Ingrese la nota necesaria para aprobar"
					nota = gets.chomp.to_f
					puts "La Nota Ingresada fue: #{nota}"
					puts "\n"
				else
					nota = 5
					puts "La Nota por defecto es: #{nota}"
				end	
				alumnos_aprobados(nota)
			when '4' #Opción 4: Salir del Sistema
				system_out()
			else
				'Ingresa un número del 1 al 4'
		end
	end