#!/bin/bash
# Si existe la carpeta opt or el fichero host, entonces dara verdadero.
if [[-d /opt || -f ~/etc/host]]; then
  echo "Esta condicion es verdadera."
else
  echo "Esta condicion es falsa."
fi


#condicion preguntado el valor de una Variable
VALUE="things"

if [[ "$VALUE" = "things"]]; then
  echo "This is 'things'"
else
  echo "This is not the right word."
fi

if [[ "$VALUE" != "things"]]; then
  echo "This is 'things'"
else
  echo "This is not the right word."
fi


if [[$1 = "y"]]; then 
  echo "Has dicho 'si'"
elif [[$1 = "n"]]; then
  echo "Has dicho 'no'"
else
  echo "Has introducido una opcion incorrecta"
fi  