# Tema 103: Comandos GNU y Unix

## Comandos básicos de ficheros

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

Para crear un directorio anidado dentro de otro utilizamos el parametro `-p`

```bash
mkdir -p Documents/notes
```

### $PATH

Todos los comandos que esten en la variable $PATH, podran ser ejecutados desde cualquier ruta del sistema.

```console
sergio@ubuntu:~$ echo $PATH
/home/sergio/gems/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

## Archivos y compresion de carpetas

`dd` - copia y convierte archivos. Se utiliza para crear fichero de un determinado tamaño y realizar copias de seguridad de unidades de disco.

`tar` - combina ficheros y directorios en un archivo. Este comando no proporciona compresión.

`gzip` -

`gunzip` - 

`bzip2` -

`bunzip2`

`xz`

`unxz`



### dd

Creamos una copiar de seguridad del sistema de arranque

```console
sergio@ubuntu:~$ sudo dd if=/dev/vda of=/tmp/mbr.img bs=512 count=1
1+0 registros leídos
1+0 registros escritos
512 bytes copied, 0,0012344 s, 415 kB/s
sergio@ubuntu:~$ ls /tmp/
```