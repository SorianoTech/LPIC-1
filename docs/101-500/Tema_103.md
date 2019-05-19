- [Tema 103: Comandos GNU y Unix](#tema-103-comandos-gnu-y-unix)
  - [103.1 Trabajar desde la linea de comandos](#1031-trabajar-desde-la-linea-de-comandos)
    - [ls](#ls)
    - [cp](#cp)
    - [rm](#rm)
    - [file](#file)
  - [Trabajando con directorios](#trabajando-con-directorios)
    - [mkdir](#mkdir)
    - [$PATH](#path)
  - [103.2 Procesar secuencias de texto usando filtros](#1032-procesar-secuencias-de-texto-usando-filtros)
    - [dd](#dd)
  - [103.3 Administración básica de archivos](#1033-administraci%C3%B3n-b%C3%A1sica-de-archivos)
    - [103.3.1 find](#10331-find)
    - [which](#which)
    - [File Globing](#file-globing)
  - [103.4 Uso de secuencias de texto, tuberías y redireccionamientos](#1034-uso-de-secuencias-de-texto-tuber%C3%ADas-y-redireccionamientos)
  - [103.5 Crear, supervisar y matar procesos](#1035-crear-supervisar-y-matar-procesos)
    - [Revisar el estado del sistema](#revisar-el-estado-del-sistema)
    - [Monitorizar procesos](#monitorizar-procesos)
  - [103.6 Modificar la prioridad de ejecución de los procesos](#1036-modificar-la-prioridad-de-ejecuci%C3%B3n-de-los-procesos)
  - [103.7 Realizar búsquedas en archivos de texto usando expresiones regulares](#1037-realizar-b%C3%BAsquedas-en-archivos-de-texto-usando-expresiones-regulares)
  - [103.8 Edición básica de archivos](#1038-edici%C3%B3n-b%C3%A1sica-de-archivos)

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
echo $OLDPWD - nos devuleve el utimo directorio

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

### $PATH

Todos los comandos que estén en la variable $PATH, podrán ser ejecutados desde cualquier ruta del sistema.

```console
sergio@ubuntu:~$ echo $PATH
/home/sergio/gems/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

## 103.2 Procesar secuencias de texto usando filtros


`less` - sirve para mostrar el texto de un fichero linea por linea

`uniq` - omite las lineas repetidas

### dd

Creamos una copiar de seguridad del sistema de arranque

```console
sergio@ubuntu:~$ sudo dd if=/dev/vda of=/tmp/mbr.img bs=512 count=1
1+0 registros leídos
1+0 registros escritos
512 bytes copied, 0,0012344 s, 415 kB/s
sergio@ubuntu:~$ ls /tmp/
```


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

Buscar ficheros

### 103.3.1 find 

`find`

 *-name*: para buscar por nombre de fichero.

 *-ctime*: encuentra ficheros basados en el momento que fueron modificados.

 *-atime*: encuentra ficheros basados en el momento que se accedió a ellos.

 *-empty*: -exec[command]{}\; ejecutamos un comando después de realizar una búsqueda, útil por ejemplo para eliminar todos los ficheros que encontremos vacios

>El comando find busca recursivamente en la carpetas que esten jerarquicamente por debajo.

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

Buscar los ficheros vacios (con `-f` buscamos los ficheros con `-d` los directorios)

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

`which` sirver para localizar donde esta instalado un paquete.

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

`xargs` : toma la entrada (el resultado de otro comando) normalmente `find`  y lo pasa a otro comando

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

## 103.5 Crear, supervisar y matar procesos


`man proc` - manual del del pseudo directorio del sistema de ficheros
`man 7 signal` - manual del los diferentes estados de las señales de procesos.

### Revisar el estado del sistema

**Procesos**: son set de intrucciones que estan cargados en la memoria.

`PID`: es el identificador del proceso

`ps`: nos muestra los procesos

>ps -a muestra todos los procesos.

>ps -eH | less - muestra todos los procesos ordenados por jerarquia.

>ps -u username - muestro los procesos de un usuario

>ps -e --forest - muestra todos los procesos en arbol


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

`pgrep`: busca información del proceso basado en el nombre del proceso

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

`kill`: mata el proceso con PID introducido, en caso de que el proceso tenga otros elementos depentiendes de el tambien matarar los procesos hijos. Envia una señal  (normalmente SIGTERM) a un proceso basado en su PID

`pstree`

`pkill` - envia una señal (normalmente SIGTERM) a un proceso basado en su nombre(mata el proceso indicando el nombre).

## 103.6 Modificar la prioridad de ejecución de los procesos


## 103.7 Realizar búsquedas en archivos de texto usando expresiones regulares

## 103.8 Edición básica de archivos