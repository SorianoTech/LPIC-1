- [Tema 104: Dispositivos, sistemas de archivos Linux y el estándar de jerarquía de archivos](#tema-104-dispositivos-sistemas-de-archivos-linux-y-el-est%C3%A1ndar-de-jerarqu%C3%ADa-de-archivos)
  - [104.1 Creación de particiones y sistemas de archivos](#1041-creaci%C3%B3n-de-particiones-y-sistemas-de-archivos)
  - [104.2 Mantener la integridad de los sistemas de archivos](#1042-mantener-la-integridad-de-los-sistemas-de-archivos)
  - [104.3 Controlar el montaje y desmontaje de los sistemas de archivos](#1043-controlar-el-montaje-y-desmontaje-de-los-sistemas-de-archivos)
  - [104.4 Eliminado](#1044-eliminado)
  - [104.5 Administración de los permisos y los propietarios de los archivos](#1045-administraci%C3%B3n-de-los-permisos-y-los-propietarios-de-los-archivos)
  - [104.6 Crear y cambiar enlaces duros y simbólicos (Hard link and symbolic link)](#1046-crear-y-cambiar-enlaces-duros-y-simb%C3%B3licos-hard-link-and-symbolic-link)
  - [104.7 Encontrar archivos de sistema y ubicar archivos en el lugar correspondiente](#1047-encontrar-archivos-de-sistema-y-ubicar-archivos-en-el-lugar-correspondiente)

# Tema 104: Dispositivos, sistemas de archivos Linux y el estándar de jerarquía de archivos


## 104.1 Creación de particiones y sistemas de archivos

swap file: es el fichero que se utiliza cuando esta la memoria ram llena.

`fdisk` - se utiliza para modificar particiones basadas en MBR

`gparted` - se utiliza para modificar particiones basadas tables de particiones GPT

`parted` - 

`mkswap` - comando para usado para formatear una partcion swap

`swapoff` - deshabilita una particion de swap

Para añadir una partción al arranque tenemos que modificar el fichero `/etc/fstab/`


Añadir una nueva partición de SWAP, añadimos al fichero fstab la siguiente informacion:

```
LABEL=SWAP swap swap defaults 0 0
```

## 104.2 Mantener la integridad de los sistemas de archivos

## 104.3 Controlar el montaje y desmontaje de los sistemas de archivos



## 104.4 Eliminado

## 104.5 Administración de los permisos y los propietarios de los archivos

`chow`: cambia el usuario propietario de un fichero o directorio.

`chgrp`: cambiar el grupo propietario de un fichero o directorio.

`chmod`: cambia el modo de acceso a los ficheros o directorios con la simbología 777 o 775.

- *Primer dígito*: permisos para propietario
- *Segundo dígito*: permisos para grupo.
- *Tercer dígito*: Permisos para otros.


    Lectura: 4
    Escritura: 2
    Ejecución: 1

    0: Sin permisos
    1: Ejecución
    2: Escritura
    3: Lectura y escritura
    4: Lectura
    5: Lectura y ejecución
    6: Lectura y escritura
    7: Lectura, escritura y ejecución

Si queremos establecer un permiso de escritura usaremos el 6 (4 + 2= Lectura + Escritura)

Si queremos que un usuario pueda ejecutar usaremos el 7 (4 + 2 + 1= Lectura + Escritura + Ejecución)

Los tipos de permisos más comunes, o su combinación, son los siguiente:

666 ( RW / RW / RW) |
---------|
 Esta opción permite que todos los usuarios puedan leer y escribir en un archivo. |

777 ( RWX / RWX /RWX) |
---------------|
Esta opción permite que todos los usuarios puedan leer y escribir en un archivo. |
 
777 ( RWX / RWX /RWX)|
---------------|
Esta opción permite que todos los usuarios puedan leer, escribir y ejecutar en el archivo o carpeta. |
 

755 (RWX / RW / RW)|
---------------|
Con este permiso el propietario del archivo puede leer, escribir y ejecutar en el archivo mientras que los demás leer y escribir en el archivo mas no ejecutar.|
 

644 (RW / R / R) |
---------------|
Con este permiso el propietario puede leer y escribir en el archivo mientras los demás solo pueden leer.|

700 (RWX /---)|
---------------|
Con este permiso el propietario tiene el control total del archivo mientras que los demás usuarios no tendrán acceso de ningún tipo al archivo.|


------

Ejercicio: Dar permisos de lectura y escritura recursivamente a una carpeta


```console
sudo chmod 666 -R /opt/myapp/*
```

## 104.6 Crear y cambiar enlaces duros y simbólicos (Hard link  and symbolic link)

La diferencia entre un enlace simbólico (soft) y uno hard, es que el hard no crea un nuevo inodo y el soft si. El hard es el mismo dato en el disco duro.

Los hard links son especialmente importantes para ficheros 'permanentes' que por ejemplo un fichero que tiene que ser solamente accesible por el administrador lincado a un fichero que nunca debe ser modificado.


Los enlaces simbolicos `ln -s` permiten cruzar sistemas de ficheros, sin embargo los hard links no. Esto ocurre porque un enlace simbolico consiste en crear un nuevo fichero que apunta a otro, sin embar un enlace duro lo que hace es crear un puntero, y el espacio ocupado en el disco es el mismo.

Para localizar los hard symbolik links:

1. Buscamos el numero del inodo del fichero
2. Buscamos los ficheros que existen con ese numero de inodo


```console
[cloud_user@ip-10-0-0-142 ~]$ ls -i docs/services
25165940 docs/services
[cloud_user@ip-10-0-0-142 ~]$ find . -inum 25165940
./docs/services
./services
[cloud_user@ip-10-0-0-142 ~]$ ls -i services
25165940 services
```

## 104.7 Encontrar archivos de sistema y ubicar archivos en el lugar correspondiente

![File System Hierarchy](img\FileSystemHierarchy.png)

[Pathname](http://www.pathname.com/fhs/)

`locate`: busca en la base de datos local ficheros y carpetas que concuerden con el criterio de búsqueda.

`updatedb`: actualiza la base de datos del comando locate.

```console
[sergio@hostingsoriano ~]$ locate updatedb
/etc/updatedb.conf
/usr/bin/updatedb
/usr/share/man/man5/updatedb.conf.5.gz
/usr/share/man/man8/updatedb.8.gz
```

`whereis`: este comando localiza los archivos binarios, codigo fuente y paginas del manual de un comando.

```console
[sergio@hostingsoriano ~]$ whereis top
top: /usr/bin/top /usr/share/man/man1/top.1.gz
[sergio@hostingsoriano ~]$ whereis nginx
nginx: /usr/sbin/nginx /usr/lib64/nginx /etc/nginx /usr/share/nginx /usr/share/man/man8/nginx.8.gz /usr/share/man/man3/nginx.3pm.gz
[sergio@hostingsoriano ~]$
```


