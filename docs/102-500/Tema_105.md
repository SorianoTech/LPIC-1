# Tema 105: Shells y scripts

## 105.1 Personalizar y usar el entorno de shell

Setting Up the Shell Environment

---

Customizing the Shell Environment

## 105.2 Personalización y escritura de scripts sencillos

 Basic Shell Scripts

 ---
 
 Adding Logic to Your Shell Scripts
 
 ----

  Bash Loops and Sequences

`for` -


`while` -

`until` -

---

`read` Leemos lo que introducimos por teclado y lo guardamos en la variable GRETTING. `read GREETING`.

`exit` - para especificar el retorno de salida, normalmente seria 0, pero se puede cambiar a otro numero, por ejemplo para salir en un bucle.

`exec` - se puede utilizar para re-direccionar la salida de una shell a un fichero. `exec > out .log`
  ---


## 106: Interfaces de usuario y escritorios

### 106.1 Instalar y configurar X11

#### 106.1.1 The Basics of X11
X11 lo llevan los antiguos sistemas (CentOS 5)
Wayland - remplaza al sistema de ventas X. 

#### 106.1.2 Instalando X11

`yum grouplist` - para ver los grupos de instalaciones.

`yum -y groupinstall "X Windows System"`

x.org se encarga de llevar el proyecto.

Podemos encontrar el fichero de configuración en `/etc/init` y veremos que apunta a `/etc/X11/prefdm` 

#### 106.1.3 Configuraciones de X11

`xorg.conf` - fichero de configuración de entorno visual de ventanas X

man `xorg,conf` - para ver toda la documentación sobre la configuración del entorno de ventanas.

`xdpyinfo` - muestra información sobre la sesión de ventanas. 

#### 106.1.4 Conexiones gráficas remotas

`xhost` - no usar para entornos de producción. (Se usaba antes) Con este comando podemos habilitar o deshabilitar el acceso remoto. 

```console
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  xhost             
access control enabled, only authorized clients can connect
SI:localuser:sergio
 sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  xhost -
access control enabled, only authorized clients can connect
 sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  xhost +
access control disabled, clients can connect from any host
```

`xauth` - sirve para editar y ver información de seguridad que permita a los usuarios controlar los clientes de ventanas X11.

`VNC` - Virtual Network computing.

Instalar el servidor de VNV:

`yum install tigervnc-server`

**Demo** de como configurar un servidor VNC y crear una redirección de puertos por ssh para conectarnos de forma segura.

`ssh -C -L 5901:localhost:5901 192.168.122.241`

5901:localhost - puerto y dirección local

5901 192.168.122.241 - puerto y dirección remota

Ahora podemos utilizar la ip local para conectarnos por VNC al escritorio remoto


`SPICE` - Protocolo de conexion seguro encriptado con TLS, permite conexoines con sistemas Windows, linux y android.

----

### 106.2 Escritorios Gráficos

GTK+ : desarrolladas en C
- GNOME
- XFCE

QT : desarrolladas en C++
 - KDE


### 106.3 Accesibilidad

Configuracion especifica de accesibildad, como zoom, punteros, lectura de ventanas por voz, etc. 
Orca permite la configuración de accesibilidad, centrándonos en la configuración de screen reader.


## 107: Tareas Administrativas

### 107.1 Administrar cuentas de usuario y de grupo y los archivos de sistema relacionados con ellas
 
#### Adding and Removing Users


---

#### Adding and Removing Groups

---

#### User and Group Configuration Files

---

#### User and Group Modifications

