# Tabla de contenido :+1:

## Objetivos del examen 101

- [ ] [Tema 101: Arquitectura del Sistema](docs/101-500/Tema_101.md)
- [ ] [Tema 102: Instalación de Linux y gestión de paquetes](docs/101-500/Tema_102.md)
- [ ] [Tema 103: Comandos GNU y Unix](docs/101-500/Tema_103.md)
- [ ] [Tema 104: Dispositivos, sistemas de archivos Linux y el estándar de jerarquía de archivos](docs/101-500/Tema_104.md)





Tema 101: Arquitectura del Sistema
101.1 Determinar y configurar los ajustes de hardware
Importancia

2
Descripción

Los candidatos deberán ser capaces de determinar y configurar el hardware fundamental del sistema.

Áreas de conocimiento clave:

Activar y desactivar los periféricos integrados.
Diferenciar entre los distintos tipos de dispositivos de almacenamiento masivo.
Determinar los recursos de hardware para los dispositivos.
Herramientas y utilidades para listar información de hardware (por ejemplo, lsusb, lspci, etc.).
Herramientas y utilidades para manipular dispositivos USB.
Conocimientos conceptuales de sysfs, udev y dbus.

Lista parcial de los archivos, términos y utilidades utilizados:

/sys/
/proc/
/dev/
modprobe
lsmod
lspci
lsusb

101.2 Arranque del sistema
Importancia

3
Descripción

Los candidatos deberán ser capaces de guiar el sistema a lo largo del proceso de arranque.

Áreas de conocimiento clave:

Proporcionar comandos comunes al gestor de arranque y opciones al kernel en el momento del arranque.
Demostrar conocimiento de la secuencia de arranque desde BIOS/UEFI hasta la finalización del arranque.
Comprensión de SysVinit y systemd.
Conocimiento de Upstart.
Comprobar los eventos de arranque en los archivos de registro.
Lista parcial de los archivos, términos y utilidades utilizados:

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


101.3 Cambiar los niveles de ejecución / objetivos de arranque y apagar o reiniciar el sistema
Importancia

3
Descripción

Los candidatos deberán ser capaces de gestionar el nivel de ejecución de SysVinit o el objetivo de arranque systemd del sistema. Este objetivo incluye cambiar al modo de usuario único, apagar o reiniciar el sistema. Los candidatos deberán ser capaces de alertar a los usuarios antes de cambiar de nivel de ejecución / objetivo de arranque y terminar adecuadamente los procesos. Este objetivo también incluye establecer el nivel de ejecución predeterminado de SysVinit o el objetivo de arranque systemd. También incluye el conocimiento de Upstart como una alternativa a SysVinit o systemd.


Áreas de conocimiento clave:

Establecer el nivel de ejecución o el objetivo de arranque predeterminado.
Cambiar entre niveles de ejecución / objetivos de arranque, incluido el modo monousuario.
Apagar y reiniciar desde la línea de comandos.
Alertar a los usuarios antes de cambiar de nivel de ejecución/objetivo de arranque u otros eventos importantes del sistema.
Terminar procesos de forma adecuada.
Conocimiento de acpid.

Lista parcial de los archivos, términos y utilidades utilizados:

/etc/inittab
shutdown
init
/etc/init.d/
telinit
systemd
systemctl
/etc/systemd/
/usr/lib/systemd/
wall

Tema 102: Instalación de Linux y gestión de paquetes
102.1 Diseño del esquema de particionado del disco duro duro
Importancia

2
Descripción

Los candidatos deberán ser capaces de diseñar un esquema de particionado de disco para un sistema Linux.

Áreas de conocimiento clave:

Asignar sistemas de archivos y espacio de intercambio a particiones o discos separados.
Adaptar el diseño al uso previsto del sistema.
Asegurar de que la partición /boot cumple los requisitos de la arquitectura de hardware para el arranque.
Conocimiento de las características básicas de LVM.
Lista parcial de archivos, términos y utilidades:

Sistema de archivos / (raíz)
Sistema de archivos /var
Sistema de archivos /home
Sistema de archivos /boot
Partición del sistema EFI (ESP)
Espacio de intercambio (swap)
Puntos de montaje
Particiones

102.2 Instalar un gestor de arranque
Importancia

2
Descripción

El candidato debe ser capaz de seleccionar, instalar y configurar un gestor de arranque.

Áreas de conocimiento clave:

Proporcionar ubicaciones alternativas para el gestor de arranque así como opciones de arranque de respaldo.
Instalar y configurar un gestor de arranque como GRUB Legacy.
Realizar cambios básicos de configuración para GRUB 2.
Interactuar con el gestor de arranque.

Lista parcial de archivos, términos y utilidades:

menu.lst, grub.cfg and grub.conf
grub-install
grub-mkconfig
MBR

102.3 Gestión de librerías compartidas
Importancia

1
Descripción

El candidato debe ser capaz de determinar de qué librerías compartidas dependen los programas ejecutables e instalarlas cuando sea necesario.

Áreas de conocimiento clave:

Identificar librerías compartidas.
Identificar las ubicaciones típicas de las librerías del sistema.
Cargar librerías compartidas.
Lista parcial de archivos, términos y utilidades:

ldd
ldconfig
/etc/ld.so.conf
LD_LIBRARY_PATH

102.4 Gestión de paquetes Debian
Importancia

3
Descripción

El candidato debe ser capaz de llevar a cabo la gestión de paquetes usando las herramientas de Debian.

Áreas de conocimiento clave:

Instalar, actualizar y desinstalar paquetes binarios de Debian.
Encontrar paquetes que contengan archivos o librerías específicos (estén o no instalados).
Obtener información del paquete como la versión, contenido, dependencias, integridad del paquete y estado de la instalación (tanto si el paquete está instalado como si no lo está).
Conocimientos de apt.
Lista parcial de archivos, términos y utilidades:

/etc/apt/sources.list
dpkg
dpkg-reconfigure
apt-get
apt-cache

102.5 Gestión de paquetes RPM y YUM
Importancia

3
Descripción

El candidato debe ser capaz de llevar a cabo la gestión de paquetes usando las herramientas RPM, YUM y Zypper.

Áreas de conocimiento clave:

Instalar, reinstalar, actualizar y desinstalar paquetes usando RPM, YUM y Zypper.
Obtener información de paquetes RPM como la versión, estado, dependencias, integridad y firmas.
Determinar qué archivos proporciona un paquete así como encontrar de qué paquete proviene un determinado archivo.
Conocimientos de dnf.
Lista parcial de archivos, términos y utilidades:

rpm
rpm2cpio
/etc/yum.conf
/etc/yum.repos.d/
yum
zypper

102.6 Linux como sistema virtualizado
Importancia

1
Descripción

El candidato debe entender las implicaciones que conlleva la virtualización y la computación en la nube en un sistema Linux virtualizado.

Áreas de conocimiento clave:

Entender el concepto general de máquina virtual y contenedor
Entender elementos comunes de una máquina virtual en un entorno de nube de tipo IaaS, tales como instancia de computación, almacenamiento de bloques y redes
Entender las propiedades únicas de un sistema Linux que tienen que cambiar cuando el sistema se clona o se usa como plantilla
Entender cómo se usan las imágenes de sistema para desplegar máquinas virtuales, instancias de nube y contenedores
Entender las extensiones de Linux que permiten la integración con un producto de virtualización
Conocimientos de cloud-init
Lista parcial de archivos, términos y utilidades:

Máquina virtual
Contenedor Linux
Contenedor de aplicaciones
Controladores de la máquina huésped
Llaves de host SSH
ID de D-Bus

Tema 103: Comandos GNU y Unix
103.1 Trabajar desde la línea de comandos
Importancia

4
Descripción

El candidato debe saber cómo usar la línea de comandos para interactuar con la shell y sus comandos. Se asume el conocimiento de la shell Bash por parte del candidato.

Áreas de conocimiento clave:

Usar comandos de shell individuales y secuencias de comandos de una línea para realizar tareas básicas en la línea de comandos.
Usar y modificar el entorno de shell, lo que incluye definir, referenciar y exportar variables de entorno.
Usar y editar el historial de comandos.
Invocar comandos dentro y fuera de la ruta definida.
Lista parcial de archivos, términos y utilidades:

bash
echo
env
export
pwd
set
unset
type
which
man
uname
history
.bash_history
Uso de comillas

103.2 Procesar secuencias de texto usando filtros
Importancia

2
Descripción

El candidato debe saber aplicar filtros a secuencias de texto.

Áreas de conocimiento clave:

Enviar archivos de texto y flujos de salida a través de filtros de utilidades de texto para modificar la salida usando comandos UNIX estándar incluidos en el paquete GNU textutils.
Lista parcial de archivos, términos y utilidades:

bzcat
cat
cut
head
less
md5sum
nl
od
paste
sed
sha256sum
sha512sum
sort
split
tail
tr
uniq
wc
xzcat
zcat

103.3 Administración básica de archivos
Importancia

4
Descripción

El candidato debe ser capaz de usar comandos básicos de Linux para la administración de archivos y directorios.

Áreas de conocimiento clave:

Copiar, mover y eliminar archivos y directorios de forma individual.
Copiar múltiples archivos y directorios de forma recursiva.
Eliminar archivos y directorios de forma recursiva.
Utilizar especificaciones de comodines simples y avanzadas en los comandos.
Usar find para localizar archivos y actuar sobre ellos en base a su tipo, tamaño o marcas de tiempo.
Uso de tar, cpio y dd.
Lista parcial de archivos, términos y utilidades:

cp
find
mkdir
mv
ls
rm
rmdir
touch
tar
cpio
dd
file
gzip
gunzip
bzip2
bunzip2
xz
unxz
Uso de comodines (file globbing)

103.4 Uso de secuencias de texto, tuberías y redireccionamientos
Importancia

4
Descripción

El candidato debe ser capaz de redireccionar secuencias de texto y conectarlas para procesar la información de forma eficiente. Estas tareas incluyen: la redirección de la entrada estándar, la salida estándar y el error estándar; el uso de tuberías para enviar la salida de un comando a la entrada de otro; el uso de la salida de un comando como argumento para otro comando, así como el envío de la salida de un comando simultáneamente a la salida estándar y a un archivo.


Áreas de conocimiento clave:

Redireccionar la entrada estándar (stdin), la salida estándar (stdout) y el error estándar (stderr).
Utilizar tuberías para enviar la salida de un comando a la entrada de otro.
Usar la salida de un comando como argumento de otro comando.
Enviar la salida de un comando a stdouty a un archivo simultáneamente.

Lista parcial de archivos, términos y utilidades:

tee
xargs

103.5 Crear, supervisar y matar procesos
Importancia

4
Descripción

El candidato debe ser capaz de realizar una gestión básica de los procesos.

Áreas de conocimiento clave:

Ejecutar trabajos en primer y segundo plano.
Enviar señales a los programas para que continúen ejecutándose después del cierre de sesión.
Supervisar procesos activos.
Seleccionar y ordenar procesos para su visualización.
Enviar señales a los procesos.
Lista parcial de archivos, términos y utilidades:

&
bg
fg
jobs
kill
nohup
ps
top
free
uptime
pgrep
pkill
killall
watch
screen
tmux

103.6 Modificar la prioridad de ejecución de los procesos
Importancia

2
Descripción

El candidato debe ser capaz de gestionar las prioridades de ejecución de los procesos.

Áreas de conocimiento clave:

Conocer la prioridad predeterminada con la que se crea un proceso.
Ejecutar un programa con una prioridad mayor o menor de la que tiene de forma predeterminada.
Cambiar la prioridad de un proceso en ejecución.
Lista parcial de archivos, términos y utilidades utilizadas:

nice
ps
renice
top

103.7 Realizar búsquedas en archivos de texto usando expresiones regulares
Importancia

3
Descripción

El candidato debe ser capaz de manipular archivos y cadenas de texto usando expresiones regulares. El objetivo incluye la creación de expresiones re\ gulares sencillas que contengan varios elementos de notación así como el uso de herramientas para realizar búsquedas con expresiones regulares dentr\ o de un sistema de archivos o del contenido de un archivo.

Áreas de conocimiento clave:

Crear expresiones regulares sencillas que contengan varios elementos de notación.
Saber diferenciar las expresiones regulares básicas de las extendidas.
Entender los conceptos de caracteres especiales, clases de caracteres, cuantificadores y anclas.
Usar herramientas para realizar búsquedas con expresiones regulares dentro de un sistema de archivos o del contenido de un archivo.
Usar las expresiones regulares para borrar, modificar o reemplazar texto.
Lista parcial de archivos, términos y utilidades:

grep
egrep
fgrep
sed
regex(7)

103.8 Edición básica de archivos
Importancia

3
Descripción

El candidato debe ser capaz de editar archivos de texto usando vi. El objetivo incluye la navegación en vi, los modos básicos de vi, así como insertar, editar, borrar, copiar y encontrar texto utilizando vi. También se incluye el conocimiento de otros editores de texto populares y saber establecer el editor predeterminado.

Áreas de conocimiento clave:

Navegar por un documento usando vi.
Entender y usar los modos de vi.
Insertar, editar, borrar, copiar y encontrar texto usando vi.
Conocimientos de Emacs, nano y vim.
Configurar el editor estándar.
Lista parcial de archivos, términos y utilidades:

vi
/, ?
h,j,k,l
i, o, a
d, p, y, dd, yy
ZZ, :w!, :q!
EDITOR

Tema 104: Dispositivos, sistemas de archivos Linux y el estándar de jerarquía de archivos
104.1 Creación de particiones y sistemas de archivos
Importancia

2
Descripción

El candidato debe ser capaz de configurar particiones de disco para después crear sistemas de archivos en medios tales como discos duros. Se incluye el manejo de las particiones swap.

Áreas de conocimiento clave:

Administrar tablas de particiones MBR y GPT
Usar diversos comandos mkfs para crear distintos sistemas de archivos tales como:
ext2/ext3/ext4
XFS
VFAT
exFAT
Conocimientos básicos del sistema de archivos Btrfs, incluyendo los sistemas de archivos multidispositivo, la compresión y los subvolúmenes.
Lista parcial de archivos, términos y utilidades:

fdisk
gdisk
parted
mkfs
mkswap

104.2 Mantener la integridad de los sistemas de archivos
Importancia

2
Descripción

El candidato debe ser capaz de mantener un sistema de archivos estándar así como los datos adicionales asociados a un sistema de archivos con registro de diario (journaling).

Áreas de conocimiento clave:

Verificar la integridad de los sistemas de archivos.
Supervisar el espacio libre y los inodos.
Solucionar problemas simples relacionados con los sistemas de archivos.
Lista parcial de archivos, términos y utilidades:

du
df
fsck
e2fsck
mke2fs
tune2fs
xfs_repair
xfs_fsr
xfs_db

104.3 Controlar el montaje y desmontaje de los sistemas de archivos
Importancia

3
Descripción

El candidato debe ser capaz de configurar el montaje de un sistema de archivos.

Áreas de conocimiento clave:

Montar y desmontar sistemas de archivos de forma manual.
Configurar el montaje del sistema de archivos en el arranque.
Configurar sistemas de archivos extraibles y montables por el usuario.
Uso de etiquetas e identificadores únicos universales (UUIDs) para la identificación y el montaje de sistemas de archivos.
Conocimientos de las unidades de montaje de systemd.
Lista parcial de archivos, términos y utilidades:

/etc/fstab
/media/
mount
umount
blkid
lsblk

104.4 Eliminado

104.5 Administración de los permisos y los propietarios de los archivos
Importancia

3
Descripción

El candidato debe ser capaz de controlar el acceso a los archivos mediante el uso apropiado de sus permisos y propietarios.

Áreas de conocimiento clave:

Administrar los permisos de acceso a archivos regulares y especiales así como a directorios.
Usar modos de acceso tales como el suid, el sgid y el sticky bit para mantener la seguridad.
Saber cambiar la máscara de creación de archivos.
Usar el campo grupo para otorgar acceso a archivos a miembros de un grupo.
Lista parcial de archivos, términos y utilidades:

chmod
umask
chown
chgrp

104.6 Crear y cambiar enlaces duros y simbólicos
Importancia

2
Descripción

El candidato debe ser capaz de crear y administrar los enlaces duros y simbólicos de un archivo.

Áreas de conocimiento clave:

Crear enlaces.
Identificar enlaces duros y/o simbólicos.
Copiar versus enlazar archivos.
Usar enlaces para facilitar las tareas de administración del sistema.
Lista parcial de archivos, términos y utilidades:

ln
ls

104.7 Encontrar archivos de sistema y ubicar archivos en el lugar correspondiente
Importancia

2
Descripción

El candidato debe estar completamente familiarizado con el Estándar de Jerarquía del Sistema de Archivos (Filesystem Hierarchy Standard, FHS), incluyendo las ubicaciones típicas de archivos y la clasificación de directorios.

Áreas de conocimiento clave:

Entender las ubicaciones correctas de los archivos bajo el criterio del FHS.
Encontrar archivos y comandos en un sistema Linux.
Conocer la ubicación y finalidad de archivos y directorios importantes tal como se definen por el FHS.
Lista parcial de archivos, términos y utilidades:

find
locate
updatedb
whereis
which
type
/etc/updatedb.conf
