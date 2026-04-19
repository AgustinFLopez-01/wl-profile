#!/bin/bash
mv configuracionAnterior.json ~/.config/kanshi/config.tmp
mv ~/.config/kanshi/config configuracionAnterior.json
mv ~/.config/kanshi/config.tmp ~/.config/kanshi/config 		
pkill kanshi
kanshi &