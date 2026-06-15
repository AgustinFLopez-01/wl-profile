# profile Laptop {
# 	output "Samsung Display Corp. 0x544B Unknown" mode 1600x900@36.403 position 0,0
# }
# profile Casa {
# 	output "Samsung Display Corp. 0x544B Unknown" mode 1600x900@60.000 position 0,0
# 	output "Sony PCVD-15XA1 0x01010101" mode 1024x768@60.004 position 1600,0
#}
#
# Este script se encarga de parsear el archivo de configuración de Kanshi y extraer la información de los perfiles 
# para poder detectar si existe un perfil con los mismos outputs, generara un archivo json con el siguiente formato:
#{
#   "profiles": [
#       {
#           "name": "profile1",
#           "outputs": [
#               "output1"["modo", "posicion"],
#               "output2"["modo", "posicion"]
#           ]
#       },
#       {
#           "name": "profile2",
#           "outputs": [
#               "output1"["modo", "posicion"],
#               "output2"["modo", "posicion"]
#           ]
#       }
#   ]
#}
#
#!bin/bash