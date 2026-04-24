#!/bin/bash
contador=0
arr=()
identificador=""
swaymsg -t get_outputs -p| grep Output | awk '{print$2}' > salidas.conf #obtiene las salidas actualmente conectadas y las guarda en salidas.conf


while IFS= read -r linea; do #ciclo que lee las salidas
    ((contador++))
    arr+=($linea)
done < salidas.conf
echo "${#arr[@]}"
for salida in "${arr[@]}"; do #ciclo para seleccionar que pantallas se van a encender
    while true; do
        read -r -p "¿Agregar '$salida' al perfil? (Y/N): " resp

        if [[ "$resp" == "Y" || "$resp" == "N" ]]; then
            break
        else
            echo "Respuesta inválida. Usa Y o N."
        fi
    done

    if [[ "$resp" == "Y" ]]; then
        identificador+="\toutput $salida enable"
    else 
    	identificador+="\toutput $salida disable"
    fi
    identificador+="\n"
done
printf "profile actual {\n $identificador }" > nuevaConfig.json
#mv configuracionAnterior.json ~/.config/kanshi/config.tmp
#mv ~/.config/kanshi/config configuracionAnterior.json
#mv ~/.config/kanshi/config.tmp ~/.config/kanshi/config 		
#pkill kanshi
#kanshi &