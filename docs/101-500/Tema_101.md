# Tema 101: Arquitectura del Sistema

- [Tema 101: Arquitectura del Sistema](#tema-101-arquitectura-del-sistema)
  - [101.1 Determinar y configurar los ajustes de hardware](#1011-determinar-y-configurar-los-ajustes-de-hardware)
    - [BIOS y UEFI](#bios-y-uefi)
    - [Sys y proc](#sys-y-proc)
    - [/dev y el comando **lsdev**](#dev-y-el-comando-lsdev)
    - [Modulos del Kernel](#modulos-del-kernel)
    - [modprobe](#modprobe)
    - [lsmod](#lsmod)
    - [lspci y lsusb](#lspci-y-lsusb)
  - [101.2 Arranque del sistema](#1012-arranque-del-sistema)
    - [Secuencia de arranque](#secuencia-de-arranque)
      - [Cargadores de arranque (boot loader)](#cargadores-de-arranque-boot-loader)
    - [DMESG](#dmesg)
  - [101.3 Cambiar los niveles de ejecución / objetivos de arranque y apagar o reiniciar el sistema](#1013-cambiar-los-niveles-de-ejecuci%C3%B3n--objetivos-de-arranque-y-apagar-o-reiniciar-el-sistema)

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

------

Página de guia -> [https://developer.ibm.com/tutorials/l-lpic1-101-1/]

### BIOS y UEFI

(BIOS): basic input/output system.
(UEFI): Unified Extensible Firmware Interface.

El **Fimeware** de un dispositivo es el *software* de solo lectura que sirve para comunicar los diferentes componentes de harware que componen los equipos informáticos entre si.

### Sys y proc

**sysfs** y **procfs** son sistemas de ficheros virtuales que se montan sobre /sys y /proc y que son usados por el kernel del sistema Linux. Procfs es el antiguo y sysfs es el moderno, aunque se siguen estando presente ambos en el sistema. Sysfs fue añadido en el *Kernel 2.6*.

**Sysfs** o /sys es un sistema de ficheros simple con ficheros que representan atributos de objetos, estos los objetos tambien son representados como directorios(carpetas) y son utilizados para obtener informacion sobre el sistema.

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
Contienen informacion sobre el sistema, como informacion de la memoria, cpu etc. Algunas configuracionenes es posible cambiarlas 'on the fly' de forma que cuenta con el cambio despues de un reinicio.

También contiene información sobre las peticiones de interrupción los Accesos Directos a Memoria (DMA) y los puertos de entradas y salidas los interfaces usados por el sistema (I/O port interface)

Podemos ver la información del sistema operativo con:

```bash
cat /proc/version
Linux version 4.4.0-143-generic (buildd@lgw01-amd64-037) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.10) ) #169-Ubuntu SMP Thu Feb 7 07:56:51 UTC 2019
```

También se puede mostrar la información de las variables del con el comando `sysctl -a`.

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

### /dev y el comando **lsdev**

El directorio [**/dev**][4] contiene los archivos especiales de dispositivos.

`lsdev` nos muestra la información de `/proc` presentándolo de una forma ordenada. Las columnas que podemos ver son:

- Device
- DMA
- IRQ
- I/O Port

>Es necesario tener instalado el paquete [procinfo][1]

### Módulos del Kernel

En GNU/Linux, el hardware lo administran los drivers del kernel, algunos de los cuales se encuentran integrados (compilados) en el kernel, y otros, en su mayor parte, son módulos independientes. Estos módulos son ficheros que suelen almacenarse en el árbol de directorios `/lib/modules`, y se pueden cargar o descargar para proporcionar acceso al hardware. Normalmente, GNU/Linux carga los módulos que necesita cuando se inicia, pero puede que en ocasiones se necesite cargar módulos manualmente.

### modprobe

El comando **modprobe** sirve para añadir o eliminar modulos del kernel de linux.

Para eliminar manualmente un drive podemos utilizar `modprobe -a` y para eliminar podemos utilizar `modprobe -c`. Con la opcion -v podemos ver lo que se ejecutado y con -n las opciones completadas con exito.

Añadir un modulo:

### lsmod

Con el comando **lsmod** podemos ver los modulos que hay actualmente cargados en el Kernel.

>Nos muestra la información formateada del archivo `/proc/modules`.

Con el comando `modinfo` podemos ver la informacion de un modulo. Podemos localizar los ficheros de modulos en la ruta `cd /lib/modules/$(uname -r)`

>`$(uname)- r` nos devuelve la version del kernel de nuestro sistema

```bash
sergio@ubuntu:~$ modinfo xor
filename:       /lib/modules/4.4.0-143-generic/kernel/crypto/xor.ko
license:        GPL
srcversion:     C02DF7938B1596D55158340
depends:
retpoline:      Y
intree:         Y
vermagic:       4.4.0-143-generic SMP mod_unload modversions 686 retpoline

```

### lspci y lsusb

Son herramientas para obtener información sobre los dispositivos pci y usb.

El comando lspci busca informacion en el fichero `/usr/share/misc/pci.ids`, que contiene la lista de los IDs conocidos (vendors, devices, classes, and subclasses) [info][3]

```bash
sergio@ubuntu:~$ lspci
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:02.0 VGA compatible controller: Device 1234:1111
00:03.0 Ethernet controller: Red Hat, Inc. Virtio network device
00:04.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)
00:05.0 Unclassified device [00ff]: Red Hat, Inc. Virtio memory balloon
00:06.0 SCSI storage controller: Red Hat, Inc. Virtio block device
```

```bash
sergio@ubuntu:~$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 0627:0001 Adomax Technology Co., Ltd
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

## 101.2 Arranque del sistema

Importancia: 3
Descripción: Los candidatos deberán ser capaces de guiar el sistema a lo largo del proceso de arranque.

**Áreas de conocimiento clave:**

- Proporcionar comandos comunes al gestor de arranque y opciones al kernel en el momento del arranque.
- Demostrar conocimiento de la secuencia de arranque desde BIOS/UEFI hasta la finalización del arranque.
- Comprensión de SysVinit y systemd.
- Conocimiento de Upstart.
- Comprobar los eventos de arranque en los archivos de registro.
- Lista parcial de los archivos, términos y utilidades utilizados:

```bash
dmesg
journalctl
BIOS
UEFI
bootloader
kernel
initramfs
init
SysVinit
systemd
```

-----

### Secuencia de arranque

La secuencia de arranque (Boot loader) es la que se encarga de realizar los procesos iniciales cuando el sistema es arrancado o reiniciado.

El programa de arranque reside en la particion del sistema y es invocado antes de iniciar el SO.

#### Cargadores de arranque (boot loader)

[GRUB2][6] (GRand Unified Bootloader, Cargador de arranque unificado

Son particiones que continen ficheros de configuracion para indicar donde se arranca el sistema.

Cuando GRUB2 lee el archivo de configuración, muestra un menu para seleccionar el sistema que se quiere arrancar.

### DMESG

Se utiliza para mostrar o controlar el buffer del anillo del kernel



## 101.3 Cambiar los niveles de ejecución / objetivos de arranque y apagar o reiniciar el sistema



[1]: https://linux.die.net/man/8/procinfo
[2]: https://www.maketecheasier.com/differences-between-uefi-and-bios/
[3]: http://manpages.ubuntu.com/manpages/xenial/man8/lspci.8.html
[4]: https://linux.die.net/sag/dev-fs.html
[5]: https://www.kernel.org/doc/html/latest/filesystems/index.html?highlight=filesystem
[6]:https://help.ubuntu.com/community/Grub2#File_Structure