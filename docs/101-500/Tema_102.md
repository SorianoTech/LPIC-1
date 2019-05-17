
- [Tema 102: Instalación de Linux y gestión de paquetes](#tema-102-instalaci%C3%B3n-de-linux-y-gesti%C3%B3n-de-paquetes)
  - [102.1 Diseño del esquema de particionado del disco](#1021-dise%C3%B1o-del-esquema-de-particionado-del-disco)
    - [LVM - Logical volumen manager](#lvm---logical-volumen-manager)
  - [102.5 Gestión de paquetes RPM y YUM](#1025-gesti%C3%B3n-de-paquetes-rpm-y-yum)
# Tema 102: Instalación de Linux y gestión de paquetes

- [ ] 102.1 Diseño del esquema de particionado del disco duro duro
- [ ] 102.2 Instalar un gestor de arranque
- [ ] 102.3 Gestión de librerías compartidas
- [ ] 102.4 Gestión de paquetes Debian
- [ ] 102.5 Gestión de paquetes RPM y YUM
- [ ] 102.6 Linux como sistema virtualizado

## 102.1 Diseño del esquema de particionado del disco

### LVM - Logical volumen manager

Nos permite crear grupos de discos o particiones que pueden ser montadasen un o varios sistemas de ficheros(fylesystems).

- Se puede utilizar para montar cualquier punto EXCEPTO /boot.
- Nos ofrece la flexibilidad de redimensionar los volúmenes ya creados.
- Podemos crear Snapshoots de los volumenes logicos.

Ejemplo de las capas de un grupo LVM.

file system         - / - /var - /swap - /home
Logical Volume (LV) -  lv_root - lv_var - lv_swap - lv_home
Grupos de Volumenes (VG) ------------- vg_base-----------
Volumenes Físicos (PV) - /dev/sda - /dev/sdb - /dev/sdc

![LVM](github\LPIC-1\docs\101-500\img\lvm.png)

`psv`: Lista los volumenes fisicos que existen en un gru po LVM.

`vgs`: list los grupos de volumenes que hay un en grupo LVM.

`lvs`: Lista los volumenes *logicos* que hay en un grupo LVM.


## 102.2 Instalar un gestor de arranque

## 102.3 Gestión de librerías compartidas

## 102.4 Gestión de paquetes Debian

## 102.6 Linux como sistema virtualizado

## 102.5 Gestión de paquetes RPM y YUM


Por ejemplo, imaginemos que al instalar un paquete RPM, nos encontramos con el problema de que requiere de dependencias que no tenemos instaladas.

Para saber la dependencia de un paquete. Por ejemplo: 


```
console
[cloud_user@ip-10-0-1-94 Downloads]$ yum provides libmozjs185*
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.advancedhosters.com
 * extras: mirrors.advancedhosters.com
 * updates: mirrors.advancedhosters.com
1:js-1.8.5-20.el7.i686 : JavaScript interpreter and libraries
Repo        : base
Matched from:
Provides    : libmozjs185.so.1.0



1:js-1.8.5-20.el7.x86_64 : JavaScript interpreter and libraries
Repo        : base
Matched from:
Provides    : libmozjs185.so.1.0()(64bit)



1:js-1.8.5-20.el7.x86_64 : JavaScript interpreter and libraries
Repo        : @base
Matched from:
Provides    : libmozjs185.so.1.0()(64bit)
```

identificamos que el paquete principal es Javascript.

>1:js-1.8.5-20.el7.x86_64 : JavaScript interpreter and libraries