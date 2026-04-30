#!/bin/bash

contador=0
arr=()
identificador=""
principal=""
salidas_sel=()
modos_sel=()
posiciones_rel=()
edid=()
opciones=("derecha" "izquierda" "arriba" "abajo")
obtener_EDID(){
    mapfile -t edid < <(
        swaymsg -t get_outputs -r | jq -r '.[]|"\(.make) \(.model) \(.serial)"'
    )
    echo "${edid[0]}"
}

swaymsg -t get_outputs -p | grep Output | awk '{print $2}' > salidas.conf

obtener_modos_monitor() {
    local mon=$1

    swaymsg -t get_outputs -p | \
    sed -n "/^Output $mon/,/^$/p" | \
    sed -n '/Available modes:/,/^$/p' | \
    grep "[0-9]" | \
    sed 's/^[[:space:]]*//'|\
    sed -E 's/[[:space:]]+\([0-9]+:[0-9]+\)[[:space:]]*$//'
}

# Leer salidas
obtener_EDID
while IFS= read -r linea; do
    ((contador++))
    arr+=("$linea")
done < salidas.conf

echo "${#arr[@]}"

# Selección de pantallas
for salida in "${arr[@]}"; do
    while true; do
        read -r -p "¿Agregar '$salida' al perfil? (Y/N): " resp

        if [[ "$resp" == "Y" || "$resp" == "N" ]]; then
            break
        else
            echo "Respuesta inválida. Usa Y o N."
        fi
    done

    if [[ "$resp" == "Y" ]]; then

        # Obtener modos
        mapfile -t modos < <(obtener_modos_monitor "$salida")

        echo "Modos disponibles para $salida:"
        for i in "${!modos[@]}"; do
            echo "$i) ${modos[$i]}"
        done

        while true; do
            read -r -p "Selecciona modo (número): " idx
            if [[ "$idx" =~ ^[0-9]+$ && -n "${modos[$idx]}" ]]; then
                modo="${modos[$idx]}"
                break
            fi
        done

        # Arreglo en los modos para quitar los espacios
        modo_limpio=$(echo "$modo" | sed 's/ @ /@/' | sed 's/ Hz//')

        # Preguntar si es principal
        if [[ -z "$principal" ]]; then
            read -r -p "¿Es la pantalla principal? (Y/N): " es_principal
            es_principal=${es_principal^^}

            if [[ "$es_principal" == "Y" ]]; then
                principal="$salida"
                posiciones_rel+=("centro")
            fi
        fi

        # Posición relativa
        if [[ "$salida" != "$principal" ]]; then
            echo "Selecciona posición para $salida:"
            select pos in "${opciones[@]}"; do
                if [[ -n "$pos" ]]; then
                    posiciones_rel+=("$pos")

                    nuevas=()
                    for o in "${opciones[@]}"; do
                        [[ "$o" != "$pos" ]] && nuevas+=("$o")
                    done
                    opciones=("${nuevas[@]}")

                    break
                fi
            done
        fi

        salidas_sel+=("$salida")
        modos_sel+=("$modo_limpio")

    else
        identificador+="\toutput $salida disable\n"
    fi
done

# Si no hay principal, usar la primera
if [[ -z "$principal" && ${#salidas_sel[@]} -gt 0 ]]; then
    principal="${salidas_sel[0]}"
    posiciones_rel[0]="centro"
fi

# Obtener resolución de la principal
for i in "${!salidas_sel[@]}"; do
    if [[ "${salidas_sel[$i]}" == "$principal" ]]; then
        res_principal="${modos_sel[$i]}"
        break
    fi
done

ancho=$(echo "$res_principal" | cut -d'x' -f1)
alto=$(echo "$res_principal" | cut -d'x' -f2 | sed 's/@.*//')

# Construcción final
for i in "${!salidas_sel[@]}"; do
    salida="${salidas_sel[$i]}"
    modo="${modos_sel[$i]}"
    pos="${posiciones_rel[$i]}"

    case "$pos" in
        centro)
            x=0; y=0;;
        derecha)
            x=$ancho; y=0;;
        izquierda)
            x=-$ancho; y=0;;
        arriba)
            x=0; y=-$alto;;
        abajo)
            x=0; y=$alto;;
    esac

    identificador+="\toutput $salida mode $modo position ${x},${y}\n"
done

printf "profile actual {\n$identificador}\n" > nuevaConfig.json
mv nuevaConfig.json ~/.config/kanshi/config.tmp
mv ~/.config/kanshi/config nuevaConfig.json
mv ~/.config/kanshi/config.tmp ~/.config/kanshi/config 		
swaymsg reload
