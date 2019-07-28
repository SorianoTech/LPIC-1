- [Tema 103: Comandos GNU y Unix](#tema-103-comandos-gnu-y-unix)
  - [103.1 Trabajar desde la linea de comandos](#1031-trabajar-desde-la-linea-de-comandos)
    - [ls](#ls)
    - [cp](#cp)
    - [rm](#rm)
    - [file](#file)
  - [Trabajando con directorios](#trabajando-con-directorios)
    - [mkdir](#mkdir)
    - [\$PATH](#path)
  - [103.2 Procesar secuencias de texto usando filtros](#1032-procesar-secuencias-de-texto-usando-filtros)
  - [103.3 Administración básica de archivos](#1033-administraci%c3%b3n-b%c3%a1sica-de-archivos)
    - [find](#find)
    - [which](#which)
    - [File Globing](#file-globing)
    - [dd](#dd)
  - [103.4 Uso de secuencias de texto, tuberías y redireccionamientos](#1034-uso-de-secuencias-de-texto-tuber%c3%adas-y-redireccionamientos)
  - [103.5 Crear, supervisar y matar procesos](#1035-crear-supervisar-y-matar-procesos)
    - [Revisar el estado del sistema](#revisar-el-estado-del-sistema)
    - [Monitorizar procesos](#monitorizar-procesos)
    - [Mantener un proceso corriendo](#mantener-un-proceso-corriendo)
  - [103.6 Modificar la prioridad de ejecución de los procesos](#1036-modificar-la-prioridad-de-ejecuci%c3%b3n-de-los-procesos)
  - [103.7 Realizar búsquedas en archivos de texto usando expresiones regulares](#1037-realizar-b%c3%basquedas-en-archivos-de-texto-usando-expresiones-regulares)
  - [103.8 Edición básica de archivos](#1038-edici%c3%b3n-b%c3%a1sica-de-archivos)

# Tema 103: Comandos GNU y Unix

## 103.1 Trabajar desde la linea de comandos

Comandos básicos para trabajar con ficheros.

- `ls` - se utiliza para listar los archivos y directorios.
- `touch` - es utilizado para modificar el sello de tiempo de un fichero, pero es mas comunmente utilizado para crear nuevos archivos.
- `cp` - comando para copiar ficheros
- `rm` - comando para borrar ficheros o carpetas.
- `mv` - comando usado para mover.
- `file` - se utiliza para para probar y determinar el tipo de un fichero.

### ls

`ls -la` - **l** para listar y **a** para mostrar todos los archivo incluidos los ocultos
`ls -lR` /etc/ - Lista recursivamente todas las capetas que hay en **/etc/**

### cp

Copiar un directorio

```console
cp -vR /etc etc_bak
```

Con el parametro -i nos pide confirmació.

### rm

Eliminamos un directorio utilizando `-rf`

```console
sergio@ubuntu:~$ rm -rf etc_bak/
```

### file

```console
sergio@ubuntu:~$ file .gitconfig
.gitconfig: ASCII text
```

## Trabajando con directorios

`cd` - comando para cambiar de directorio
`mkdir` - para crear un directorio
`rmdir` - eliminar un directorio
`$PATH` - variable de entorno que describe el directorio donde los usuarios pueden ejecutar una aplicacion sin especificar la ruta completa.

`cd -` volvemos al ultimo directorio en el que hemos estado.
echo \$OLDPWD - nos devuleve el utimo directorio

```console
sergio@ubuntu:~$ cd NAS/
sergio@ubuntu:~/NAS$ cd -
/home/sergio
sergio@ubuntu:~$ echo $OLDPWD
/home/sergio/NAS
```

Para volver dos directorios atrás

```
sergio@ubuntu:/etc/systemd/system$ cd ../..
sergio@ubuntu:/etc$
```

### mkdir

Para crear un directorio anidado dentro de otro utilizamos el parámetro `-p`

```bash
mkdir -p Documents/notes
```

### \$PATH

Todos los comandos que estén en la variable \$PATH, podrán ser ejecutados desde cualquier ruta del sistema.

```console
sergio@ubuntu:~$ echo $PATH
/home/sergio/gems/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

## 103.2 Procesar secuencias de texto usando filtros

`less` - sirve para mostrar el texto de un fichero linea por linea

`uniq` - omite las lineas repetidas

## 103.3 Administración básica de archivos

Archivos y compresión de carpetas

`dd` - copia y convierte archivos. Se utiliza para crear fichero de un determinado tamaño y realizar copias de seguridad de unidades de disco.

`tar` - combina ficheros y directorios en un archivo. Este comando no proporciona compresión.

`gzip` - comprime ficheros en formato gz.

`gunzip` - descomprime ficheros en formato gz

`bzip2` - comprime ficheros en formato bz2.

`bunzip2` - descomprime ficheros en bz2.

`xz` - comprime ficheros en formato xz.

`unxz` - descomprime ficheros formato xz.

Los diferentes tipos de ficheros que podemos encontrar en linux son:

- **Archivos regulares**(-)

- **Directory files(d)**

- **Archivos especiales**:
  - Archivo bloqueado(b)
  - Carácter de archivo de dispositivo(c)
  - Named pipe file or just a pipe file(p)
  - Archivo de enlace simbólico(l)
  - Archivo de Socket (s)

Buscar ficheros

### find

`find`

_-name_: para buscar por nombre de fichero.

_-ctime_: encuentra ficheros basados en el momento que fueron modificados.

_-atime_: encuentra ficheros basados en el momento que se accedió a ellos.

_-empty_: -exec[command]{}\; ejecutamos un comando después de realizar una búsqueda, útil por ejemplo para eliminar todos los ficheros que encontremos vacios

> El comando find busca recursivamente en la carpetas que esten jerarquicamente por debajo.

```console
sergio@ubuntu:~$ sudo find / -name passwd
/usr/bin/passwd
/usr/share/lintian/overrides/passwd
/usr/share/doc/passwd
/usr/share/bash-completion/completions/passwd
/etc/cron.daily/passwd
/etc/passwd
/etc/pam.d/passwd
```

Buscar los ficheros del directorio home modificados en el ultimo día

```console
sergio@ubuntu:~$ find . -ctime -1
.
./a_file
./.bash_history
./Projects
./Documents
./Documents/notes
```

Ficheros modificados en los últimos dos días

```console
sergio@ubuntu:~$ find . -atime -2
```

Buscar los ficheros vacíos (con `-f` buscamos los ficheros con `-d` los directorios)

```console
sergio@ubuntu:~$find . -empty -type -f
```

Borrar todos los ficheros vacios

```console
find . -empty -type f -exec rm -fv {} \;
```

Buscar en el home del usuario todos los archivos comprimidos y copiarlos a la carpeta test

```console
find ~ -name "*.tar.*" -exec cp -v {} /home/sergio/test \;
```

### which

`which` sirve para localizar donde esta instalado un paquete.

```console
[sergio@hostingsoriano ~]$ which nginx
/usr/sbin/nginx
```

### File Globing

`*`: localiza cero o mas caracteres

`?`: localiza cualquier caracter exacto.

`[abc]`: localiza cualquier de los caracteres de la lista, es sensible a mayusculas.

`[^abc]`: localiza cualquier caracter menos los de la lista.

`[0-9]`: licaliza un rango de numeros.

muestra los ficheros que empiezan por B o b y tienen extension js.

```console
sergio@ubuntu:~/blockchain/curso-bitcoin-blockchain-piloto$ ls [Bb]*.js
BasicCoin.js  BasicPoWCoin.js
```

Creamos varios directorios en una misma orden

```console
sergio@ubuntu:~$ mkdir -p Projects/{A,B,C,D}
sergio@ubuntu:~$ ls Projects/
A  B  C  D
sergio@ubuntu:~$
```

Ver el contenido de un archivo comprimido

```console
catxz archivo.xz
```

mostrar la columna 6 del archivo de usuarios passwd

```console
sergio@ubuntu:~/$ cut -f 6 -d ':' /etc/passwd
```

Combinar el contenido de dos ficheros

```console
sergio@ubuntu:~$ paste file1 file2
```

### dd

Nos sirve para crear una copia exacta de un dispositivo de almacenamiento, copiar una imagen a un pendrive, o cualquier tarea que requiere copiar o clonar información de un medio a otro.

Podemos crear por ejemplo crear una copiar de seguridad del sistema de arranque:

```console
sergio@ubuntu:~$ sudo dd if=/dev/vda of=/tmp/mbr.img bs=512 count=1
1+0 registros leídos
1+0 registros escritos
512 bytes copied, 0,0012344 s, 415 kB/s
sergio@ubuntu:~$ ls /tmp/
```

Es necesario un **origen**(if) y un **destino** (of)

la opcion `bs=512` sirve para indicar que tanto en la lectura como en la escritura se hagan bloques de 512 BYTES

Para copiar el MBR:

```console
sudo dd if=/dev/hda |pv|dd of=mbr count=1 bs=512
```

## 103.4 Uso de secuencias de texto, tuberías y redireccionamientos

Redirigiendo las salidas con los caracteres >,>>

input y output

input <, |
abreviatura 'stdin'

```console
wc test.sh (input proviene del teclado)
wc < test.sh (input proviene de un arhivo)
cat /etc/passwod  | less (input proviene de stdout del comando cat)
```

standar error -> 'stdeer'

`tee`: concatenado con el comando find nos devuelve la salida de find en un fichero.

```console
find / -iname "*.sh" | tee result.txt
```

`xargs` : toma la entrada (el resultado de otro comando) normalmente `find` y lo pasa a otro comando

Listar todas las carpetas de librerías disponibles, pasar a un fichero y ordenar en otro fichero

```console
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  ls -d /usr/share/doc/lib[Xx]* | tee lib.docs.txt | sort -r | tee lib-docs-rev.txt
```

Buscar todos los fichero con la extension sh e imprimir los resultados con el comando ls en un fichero.

```console
find / -name "*.sh" | xargs ls -al > myresult.txt
```

Buscar todos lo ficheros dentro de carpeta test que tengan la palabra junk y moverlos a la carpeta bak. el parámetro -l obtendrá el nombre del fichero.

```console
grep -l "junk" test/file_* | xargs -I {} mv {} test/bak/
```

Eliminar todos los ficheros que encontremos con locate

```
sudo locate whatever | xargs rm -f
```

## 103.5 Crear, supervisar y matar procesos

En este tema aprenderemos a ejecutar trabajos en primer y segundo plano, enviar señales a los programas para que se ejecuten despues de cerrar una sesión, supervisar procesos activos, ordenar los procesos para visualizarlos y enviar señales a los procesos.

`man proc` - manual del del pseudo directorio del sistema de ficheros.

`man 7 signal` - manual del los diferentes estados de las señales de procesos.

### Revisar el estado del sistema

**Procesos**: son set de intrucciones que estan cargados en la memoria.

`PID`: es el identificador del proceso

`ps`: nos muestra los procesos

> ps -a muestra todos los procesos.

> ps -eH | less - muestra todos los procesos ordenados por jerarquia.

> ps -u username - muestro los procesos de un usuario

> ps -e --forest - muestra todos los procesos en arbol

`top`: sirve para ver los proceso que hay activos

Si pulsamos la tecla `k` y escribimos el PID del procesos lo matamos.

### Monitorizar procesos

`uptime` para conocer el tiempo que lleva arrancado el sistem.

```console
[sergio@hostingsoriano ~]$ uptime
 21:48:41 up  2:06,  1 user,  load average: 0,00, 0,01, 0,05
```

`free`: sirve para conocer la memoria ram y de la partición de swap.

```console
sergio@Lenovo:~/GITHUB/LPIC-1$ free -h
              total        used        free      shared  buff/cache   available
Mem:           7,5G        4,8G        609M        542M        2,1G        2,1G
Swap:          2,0G        111M        1,9G

```

`pgrep`: nos devuelve el PID del proceso basado en el nombre.

> Con pgrep -a nginx nos muestra el proceso con la ruta completa.

```console
[root@hostingsoriano sergio]# pgrep nginx
14686
14711
[root@hostingsoriano sergio]# pgrep -a nginx
14686 nginx: master process nginx -g daemon off;
14711 nginx: worker process
[root@hostingsoriano sergio]# pgrep -u sergio
13666
13667
```

`kill`: mata el proceso con PID introducido, en caso de que el proceso tenga otros elementos depentiendes de el tambien matarar los procesos hijos. Envia una señal (normalmente SIGTERM) a un proceso basado en su PID

`pstree` - nos muestra un arbol de los procesos.

`pkill` - envía una señal (normalmente SIGTERM) a un proceso basado en su nombre(mata el proceso indicando el nombre).

La diferencia entre SIGTERM y SIGKILL, es que el kill mata todos los procesos hijos, y SIGTERM solo el proceso en cuestión.

> Se recomienda utilizar SIGTERM(15) antes de utilizar SIGKILL(9).

---

### Mantener un proceso corriendo

Las tareas son procesos que son gestionados por con consola(shell). A cada tarea se asigna un ID se forma secuencial. Y puesto que cada tarea es un proceso tambien lleva asociado un PID.

Tenemos que entender la diferencia que existe entre tareas que se ejecuta en primer plano(_foreground_) y en segundo plano(_background_).

**Foreground**: una teare se ejecuta en primer plano cuando esta ha sido lanzada desde una terminal, la terminal se queda ocupada hasta que no ha temirnado de ejecutar la tarea.

**Background**: cuando escribes una ampersand `&` al final de la ejecución que pasas por la linea de comandos. De esta manera el proceso se ejecuta en segundo plano.

Una tarea o trabajo que ejecutemos puede tener diferentes estados:

- **Runnung**: cuando se ejecuta en consola o segundo plano.
- **Suspended**: pasa a suspendida cuando una vez lanzada pulsamos `control + z`
- **Stopped**: la tarea se para cuando si es lanzada por consola presionamos `control + c`

`killall` - mata todos los procesos basados en el nombre

sudo killall nginx

`watch` - ejecuta un comando en intervalos, por ejemplo df cada 5 segundos para saber si el disco se esta llenando.

```
watch -n 5 df
```

`screen` - permite ejecutar una consola en una nueva sesión, por ejemplo si nos conectamos a un servidor y queremos que se nos mantenga la consola abierta en caso de que perdamos la conexón.

> Ejecutamos screen -r para volver a la sesion que habiamos dejado abierta

> Para dejar en segundo plano tenemos que pulsar Control+a y Control+d

`tmux` - es como screen pero con mas funciones.

Ejemplos [aquí](http://www.sromero.org/wiki/linux/aplicaciones/tmux)

Por ejemplo para conectarnos a un servidor

1. tmux - nos abre una nueva terminal bajo tmux.
2. Nos conectamos a un servidor remote (SSH).
3. Presionamos `Control+b+d` para volver a nuestro equipo(dejando la sesion abierta).

`tmux ls` - para ver las sesioes abiertas.

Para volver a una sesion abierta.

```
tmux attach-session -t 0
```

`nohup` - un comando que lanzemos escribiendo previeamente nohup, se seguira ejecutando hasta que no se cierre la sesion con la que nos hemos logado. Nos crea un fichero **nohup.out** que podemos consultar con tail.

```console
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~/GITHUB/LPIC-1   master ●✚  nohup ping www.sergiosoriano.es &
[1] 21518
nohup: ignoring input and appending output to 'nohup.out'
 ⚙ sergio@Lenovo-ideapad-710S-Plus-13IKB  ~/GITHUB/LPIC-1   master ●✚  jobs
[1]  + running    nohup ping www.sergiosoriano.es
```

`tail -f nohup.out`

Para conocer el PID del proceso ejecutamos.

```console
⚙ sergio@Lenovo-ideapad-710S-Plus-13IKB  ~/GITHUB/LPIC-1   master ●✚  jobs -l
[1]  + 21518 running    nohup ping www.sergiosoriano.es
```

`fg` - sirve para traer un tareas de segundo plano al primer plano. `fg %1` donde `%1` es el número de la tarea que podemos ver con la orden `jobs`.

`bg` - sirve para ejecutar tareas suspendias en segundo plano. Si hemos lanzado una tarea y la hemos dejado en estado suspendido, podemos relanzarla en segundo plano ejecutando `bg %1`.

[Ejemplos](https://www.thegeekdiary.com/understanding-the-job-control-commands-in-linux-bg-fg-and-ctrlz/)

## 103.6 Modificar la prioridad de ejecución de los procesos

Manejar la prioridad de los procesos y ejeutar trabajos con diferentes prioridades.

`nice` - sirve para asignar la prioridad de un proceso.

`ps` - muestra los procesos activos. Con `ps -a` vemos todos los procesos.

`renice` - para cambiar la prioridad de un proceso

`top` - nos muestra los procesos activos.

## 103.7 Realizar búsquedas en archivos de texto usando expresiones regulares

Buscar una cadena de texto en un fichero

`grep -i 'texto' fichero`

Con el parametro `-i` ignora si el texto esta en mayúsculas o minúsculas.

`grep` - Podemos utilizarlo para buscar cadenas de texto en ficheros, directorios y salidas de otros comandos.

`egrep` - Igual que el comando grep pero sin necesidad de añadir el parametro `-E` que nos permite extender el comando para utilizar expresiones regulares.

`fgrep` - Igual que el comando grep opero sin necesidad de añadir el parametro `-F` que nos permite buscar cadenas de texto en **más de un** fichero que le indiquemos como parámetro.

`sed` - Este comando nos permite modificar el contenido de fichetos de texto.

`regex(7)` - Expresiones regulares. Mas información [aquí](http://man7.org/linux/man-pages/man7/regex.7.html)

<h3>Ejemplos</h3>

1. Buscar el texto 'apache' recursivamente en el home del usuario

```s
grep -Ril apache ~/
```

2.Buscar los usuarios que existen en el fichero de passwd que empiecen por ope y ademas tengan una
'n' o 'r' en la siguiente letra.

```s
egrep '^ope(n|r)' /etc/passwd
```

3. Mostrar todas las cuentas que no tienen habilitado el login

```
grep "nologin" /etc/passwd
```

[Generador de expresiones regulares](https://regexr.com/)

4. Cambia la palabra web por web site del ficher myfile

```s
sed 's/web/website/' ./myfile
```

5.  Buscar el shell de bash y reemplazarlo con el shell csh en el archivo /etc./passwd utilizando sed

```s
sed 's!/bin/bash!/bin/csh!' /etc/passwd
```

Más ejemplos [aquí](http://www.sromero.org/wiki/linux/aplicaciones/uso_de_sed)

## 103.8 Edición básica de archivos

Uso de VI

- [] Navegar por un documento usando vi.
- [] Entender y usar los modos de vi.
- [] Insertar, editar, borrar, copiar y encontrar texto usando vi.
- [] Conocimientos de Emacs, nano y vim.
- [] Configurar el editor estándar.

`/, ?` - buscar una cadena de texto

`h,j,k,l` - la misma funcion que las flechas de movimiento, arriba, abajo, izquierda y derecha entre carćteres y lineas.

`i, o, a` - para insertar caracteres, con `i` a la izquierda, `o` añade una nueva linea y con `a` a la derecha del cursor.

`d, p, y, dd, yy` - `d` para eliminar , `p` para pegar y `y` para copiar.

`dd` - elimna la linea completa sobre la que estas situado

`yy` - copia la linea.

`p` - pega el texto copiado.

`ZZ, :w!, :q!`

`:w!` - guardar.

`:q!` - salir sin guardar.

`ZZ` - guarda el documento y salir.

https://vim.fandom.com/wiki/Vim_Tips_Wiki

Mas información [aquí](https://www.thegeekdiary.com/basic-vi-commands-cheat-sheet/)
