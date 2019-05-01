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
- Nos ofrece la flexibilidad de redimensionar los volumenes ya creados.
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