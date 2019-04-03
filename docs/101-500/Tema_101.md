# Tema 101: Arquitectura del Sistema

- [ ] 101.1 Determinar y configurar los ajustes de hardware.
- [ ] 101.2 Arranque del sistema.
- [ ] 101.3 Cambiar los niveles de ejecución / objetivos de arranque y apagar o reiniciar el sistema.

## 101.1 Determinar y configurar los ajustes de hardware

Importancia: 2
Descripción: Los candidatos deberán ser capaces de determinar y configurar el hardware fundamental del sistema.

**Áreas de conocimiento clave**:

- Activar y desactivar los periféricos integrados.
- Diferenciar entre los distintos tipos de dispositivos de almacenamiento masivo.
- Determinar los recursos de hardware para los dispositivos.
- Herramientas y utilidades para listar información de hardware (por ejemplo, lsusb, lspci, etc.).
- Herramientas y utilidades para manipular dispositivos USB.
- Conocimientos conceptuales de sysfs, udev y dbus.

Lista parcial de los archivos, términos y utilidades utilizados:

```bash
/sys/
/proc/
/dev/
modprobe
lsmod
lspci
lsusb
```

## Guia de estudio

Página de guia -> [https://developer.ibm.com/tutorials/l-lpic1-101-1/]

### Sys y proc

**sys** y **proc** son sistemas de ficheros virtuales que se montan sobre /sys y /proc y que son usados por el kernel del sistema Linux. 

**Sysfs** o sys es un sistema de ficheros simple con ficheros que representan atributos de objetos, estos los objetos tambien son representados como directorios(carpetas) y son utilizados para obtener informacion sobre el sistema.

<https://github.com/torvalds/linux/blob/master/Documentation/filesystems/sysfs.txt>

Las carpetas que podemos encontrar dentro de /sys son:

```bash
sergio@ubuntu:~$ ls /sys
block  bus  class  dev  devices  firmware  fs  hypervisor  kernel  module  power
```

- **block**: encontramos enlaces simbolicos a dispositivos bloqueados
- **bus**: Contiene un diseño de directorio plano de los diferentes tipos de
kernel(núcleo).
- **dev**: contiene enlaces simbólicos para cada dispositivo descubierto en el sistema que apuntan al directorio del dispositivo bajo root /.
- **devices**: contiene un directorio por cada driver.

```bash
sergio@ubuntu:~$ ls -l /sys/block/
total 0
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop0 -> ../devices/virtual/block/loop0
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop1 -> ../devices/virtual/block/loop1
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop2 -> ../devices/virtual/block/loop2
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop3 -> ../devices/virtual/block/loop3
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop4 -> ../devices/virtual/block/loop4
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop5 -> ../devices/virtual/block/loop5
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop6 -> ../devices/virtual/block/loop6
lrwxrwxrwx 1 root root 0 abr  3 14:19 loop7 -> ../devices/virtual/block/loop7
lrwxrwxrwx 1 root root 0 abr  3 14:19 sr0 -> ../devices/pci0000:00/0000:00:01.1/ata2/host1/target1:0:0/1:0:0:0/block/sr0
lrwxrwxrwx 1 root root 0 abr  3 13:59 vda -> ../devices/pci0000:00/0000:00:06.0/virtio2/block/vda
```

**procfs** y /proc
Contienen informacion sobre el sistema, como informacion de la memoria, cpu etc.

Tambien se puede mostrar la informacion de las variables del con el comando `sysctl -a`.

Por ejemplo podemos mostrar las entradas del proceso activo. `$$` es el PID del la consola que esta activa.

```bash
sergio@ubuntu:~$ ls -l /proc/$$/ | head -n 15
total 0
dr-xr-xr-x 2 sergio sergio 0 abr  3 15:13 attr
-rw-r--r-- 1 sergio sergio 0 abr  3 15:13 autogroup
-r-------- 1 sergio sergio 0 abr  3 15:13 auxv
-r--r--r-- 1 sergio sergio 0 abr  3 15:13 cgroup
--w------- 1 sergio sergio 0 abr  3 15:13 clear_refs
-r--r--r-- 1 sergio sergio 0 abr  3 15:13 cmdline
-rw-r--r-- 1 sergio sergio 0 abr  3 15:13 comm
-rw-r--r-- 1 sergio sergio 0 abr  3 15:13 coredump_filter
-r--r--r-- 1 sergio sergio 0 abr  3 15:13 cpuset
lrwxrwxrwx 1 sergio sergio 0 abr  3 15:13 cwd -> /home/sergio
-r-------- 1 sergio sergio 0 abr  3 15:13 environ
lrwxrwxrwx 1 sergio sergio 0 abr  3 15:13 exe -> /bin/bash
dr-x------ 2 sergio sergio 0 abr  3 12:29 fd
dr-x------ 2 sergio sergio 0 abr  3 15:13 fdinfo
```

### El comando **lsdev**

`lsdev` nos muestra la información de `/proc` presentandolo de una forma ordenada. Las columnas que podemos ver son:

- Device:
- DMA:
- IRQ:
- I/O Port:

>Es necesario tener instalado el paquete[procinfo][1]


-------------TODO--------------
modprobe
lsmod
lspci
lsusb

### Enlaces

Documentacion sobre el sistema de ficheros del kernel de linux
[<https://www.kernel.org/doc/html/latest/filesystems/index.html?highlight=filesystem]>

[1]: https://linux.die.net/man/8/procinfo


## 101.2 Arranque del sistema

## 101.3 Cambiar los niveles de ejecución / objetivos de arranque y apagar o reiniciar el sistema
