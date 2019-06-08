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

`xhost` - no usar para entornos de producción. (Se usaba antes) con este comando podemos habilitar o deshabilitar el acceso remoto. 

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


`SPICE` - Protocolo de conexión seguro encriptado con TLS, permite conexiones con sistemas Windows, linux y android.

----

### 106.2 Escritorios Gráficos

GTK+ : desarrolladas en C
- GNOME
- XFCE

QT : desarrolladas en C++
 - KDE


### 106.3 Accesibilidad

Configuración especifica de accesibildad, como zoom, punteros, lectura de ventanas por voz, etc. 
Orca permite la configuración de accesibilidad, centrándonos en la configuración de screen reader.


## 107: Tareas Administrativas

### 107.1 Administrar cuentas de usuario y de grupo y los archivos de sistema relacionados con ellas
 
#### Añadir y eliminar usuarios

`useradd`

```console
sudo useradd -m name
```

Usamos `-m` para crear el home del usuario.
En algunas distribuciones no es necesario utilizar -m, ya que crean automáticamente la carpeta.

Creamos un usuario que utilice una shell diferente.

```console
sudo useradd -m -c "Juanjo Garcia" -s /bin/tcsh \ juanjo
```

Podemos comprobar la shell con `echo $SHELL` que nos devolverá el valor de la shell que el usuario esta utilizando.

`passwd` - comando para asignar un password al usuario.

Asignamos un password temporal con `-e` al usuario juanto

```
sudo passwd -e juanjo
```

`userdel` - comando para eliminar un usuario.

Elimina el usuario y borra las carpetas de home.

```
userdel -r juanjo
``` 
---
#### Añadir y eliminar grupos

`groups` - comando para conocer los grupos primarios y secundarios de los que forma parte el usuario.

`groupadd` - añade un nuevo grupo.

Creamos un grupo legal y creamos un usuario y lo añadimos a ese grupo.

```
sudo groupadd legal
sudo useradd -G legal -m -c "Mario Gonzalez" \ mgonzalez
```

`groupdel` - comando para borrar un grupo.
---

#### Usuarios y configuración de ficheros de grupo

`/etc/passwd` - fichero que contiene las cuentas de usuario del sistema.

Las columnas se separan por el carácter `:` y cada una de las columnas significa:

1. Nombre de usuario
2. X password encriptado
3. User id (las cuentas por encima de un id 1000 son cuentas de usuario "normales")
4. Primary Group id
5 .User id info
6. Directorio del home de usuario
7. bash que utiliza el usuario (si no ha iniciado sesion aparecera nologin)

`/etc/shadow` - fichero que contiene las password encriptadas de los usuarios. Justo después del nombre de usuario aparece el tipo de cifrado que utiliza la contraseña.

```
$1$ = MD5
$2a$,$2y$ = Blowfish
$5$ = SHA-256
$6$ = SHA-512
```
Las columnas que podemos encontrar en el fichero `/etc/shadow` son las siguientes:

  1. Nombre usuario
  2. Algoritmo de cifrado, y hash.
  3. Tiempo desde 1 enero de 1970.
  4. Los días que han pasado desde que el usuario a cambiado el password.
  5. El tiempo de días que es valido el password.
  6. Los días que sera avisado antes de que expire el password. 
  7. empty
  8. empty.


Si una cuenta tiene en la segunda columna  los caracteres de `!!` significa que esta bloqueada.

`/etc/group` - fichero que contiene información sobre los grupos de usuarios.

1. Nombre del grupo
2. Password del grupo.
3. ID del grupo.
4. los usuarios que forman parte del grupo.

---

#### Modificaciones de usuarios y grupos

`usermod` - este comando se utiliza para modificar configuraciones de usuarios ya existentes.

`change` - este comando puede listar y modificar los parámetros de expiración de password y expiración de la cuenta de usuario.

`groupmod` - modifica los atributos de un grupos, como el nombre o ID.

`getent passwd sergio` - muestra información de las bases de datos del sistema. [Enlace](https://www.unixtutorial.org/commands/getent)

----
##### Ejercicios

Añadir un usuario a un grupo ya creado.

`usermod -a -G nombregrupo nombreusuario`

Bloquear una cuenta

`usermod -L nombresusuario`

Creamos una cuenta y la bloqueamos, podemos ver como al pricipio de la ultima linea, aparece un simbolo de exclamación al consultar el fichero shadow indicandonos que la cuenta ha sido bloqueada.

```console
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  sudo getent shadow test  
test:$6$HPi6/BE7$a22bOjrx8EbVgiEdl8IMHZwSeabQX568ydN88oD3pc301BkfFgqIDClkWPS2ihjVOdL8rm./pH5M4XkYXSLik.:18055:0:99999:7:::
 sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  usermod -L test 
usermod: Permission denied.
usermod: cannot lock /etc/passwd; try again later.
 ✘ sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  sudo usermod -L test
 sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  sudo getent shadow test
test:!$6$HPi6/BE7$a22bOjrx8EbVgiEdl8IMHZwSeabQX568ydN88oD3pc301BkfFgqIDClkWPS2ihjVOdL8rm./pH5M4XkYXSLik.:18055:0:99999:7:::
```

Para desbloquearla utilizamos.

`usermod -U test`

Creamos una cuenta del sistema y modificamos su shell y su carpeta de home.

```
useradd -r projectx
usermod -s /sbin/nologin
userdmod -d /opt/projectx projectx
```

 En la ultima linea indicamos la nueva ruta del home y el usuario que queremos modificar.

 Por último, asignamos como propietario a la carpeta:

 ```console
 sudo chmod projext:projectx /opt/projectx
 ```

### 107.2 Automatizar tareas administrativas del sistema mediante la programación de trabajos

#### CRON

Lo utilizamos para programar tareas que van a ser ejecutadas en periodos de tiempo que nosotros decidamos.

`contrab -e` - para modificar el fichero de cron.

`/etc/crontab` - fichero con los trabajos programados del sistemas

`/etc/cron.d/` - directorio que contiene los trabajos progrmados del sistema. se crea un fichero por cada tarea añadida.

1. Minutos
2. Horas
3. Dia del mes (podemos usar * para indicar que no importa el dia que sea)
4. Mes (* si no nos importa el mes).
5. Dia de la semana(sat, para que se ejecute los sábados).
6. Username(el usuario que ejecuta la tarea).
7. La tarea que queremos que ejecute.

[Ejemplos](http://researchhubs.com/post/computing/linux-cmd/awesome-crontab-job-examples.html)


Los ficheros de las configuracion de cada uno de los usuarios son creados en:

`sudo cat  /var/spool/cron/crontabs/sergio`

Podemos utilizar `crontab -l` para ver las tareas programadas del usuario.

Para borrar el contenido el fichero de cron usamos el comando `crontab -r`.

Si queremos borrar el de un usuario:

`crontab -r -u sergio`

Podemos bloquear a un usuario para que no pueda crear cron añadiendolo al fichero `/etc/cron.denny`



#### At


#### Systemd Timer Unit Files
