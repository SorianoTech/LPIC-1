# 110: Seguridad

## 110.1 Tareas de administración de seguridad

### Determinar el estado actual de seguridad del sistema

`who` - lista los usuarios que estan actualente logados en el sistema.

`w` - igual que el anterior, pero además muestra el proceso que estan ejecutando.

```s
03:26:36 up 1 day,  9:21,  1 user,  load average: 1,29, 1,31, 1,15
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
sergio   :0       :0               dom18   ?xdm?   5:32   0.00s /usr/lib/gdm3/g
```

`last` - este comando muestra el historico de los usuarios logados en el sistema.

Mostrar los usuarios que se han logado en el sistema pero que no estan actualmente logados, para conocer que usuarios ha realizado intentos fallos de acceso.

```s
last -f /var/log/btmp
```

`lsof` - este comando se puede utilizar para encontrar que ficheros hay abiertos. Como los puertos de red también son considerados ficheros en Linux, podemos encontrar los puertos que estan abiertos.

Nos muestra las siguientes columnas:

- COMMAND
- PID
- TIP
- USER
- FD
- TYPE
- DEVICE
- SIZE

Buscar los ficheros que tienen activado el permiso especial SUID

```s
find / -perm -u+s
```

`ulimit` - este comando sirve para poner límites a la cantidad de recursos del sistema que usuario puede utilizar. Si cabiamos la configuración se pierde después de reinciar el sistema.

```s
ulimit -a
-t: cpu time (seconds)              unlimited
-f: file size (blocks)              unlimited
-d: data seg size (kbytes)          unlimited
-s: stack size (kbytes)             8192
-c: core file size (blocks)         0
-m: resident set size (kbytes)      unlimited
-u: processes                       30385
-n: file descriptors                1024
-l: locked-in-memory size (kbytes)  16384
-v: address space (kbytes)          unlimited
-x: file locks                      unlimited
-i: pending signals                 30385
-q: bytes in POSIX msg queues       819200
-e: max nice                        0
-r: max rt priority                 0
-N 15:                              unlimited
```

Para que sea permanente tenemos que modificar el fichero **/etc/security/limits.conf**. El fichero esta documentado con ejemplos,

Ejemplos [aquí](https://blog.carreralinux.com.ar/2016/07/uso-de-recursos-del-sistema-en-linux/)

Limitar que un usuario solo pueda utilizar 2GB de RAM.

```
sergio hard memlock 2048
```

Limitar que un usuario no pueda consumir más CPU.

```
sergio  soft  cpu 150
sergio  hard  cpu 200
```

`/etc/sudoers` - fichero de configuración donde se guardan los usuarios que tienen acceso de sudo. Se puede modificar con el comando `visudo`.

El comando **sudo** se utiliza para prevenir que los usuario pueda cometer errores accidentales al ejecutar una orden. Permite a los usuarios ejecutar un comando con permisos de root.

La barra (-) se utiliza

`su` - substitute user, para logarnos con un usuario en concreto, por defecto si no especificamos usuario, utilizara root.

```s
su - sergio
```

### Comprobar la segurida de la red local

`lsof -i` - utilizando el parámetro **-i** podemos ver los puertos que estan abierto, ya que estos ficheros estan siendo utilizados por el sistema.

En el siguiente código podemos ver como dropbox tiene conexiones establecidad y en escucha.

```s
COMMAND     PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
dropbox    1048 sergio   76u  IPv6  40146      0t0  TCP *:db-lsp (LISTEN)
dropbox    1048 sergio   78u  IPv4  40147      0t0  TCP *:db-lsp (LISTEN)
dropbox    1048 sergio   79u  IPv4  36159      0t0  UDP *:17500
dropbox    1048 sergio   80u  IPv4  37565      0t0  TCP lenovo-ideapad-710s-plus-13ikb.home:55316->162.125.68.3:https (CLOSE_WAIT)
dropbox    1048 sergio  103u  IPv4  38259      0t0  TCP localhost:17600 (LISTEN)
dropbox    1048 sergio  107u  IPv4  38262      0t0  TCP localhost:17603 (LISTEN)
dropbox    1048 sergio  113u  IPv4 492743      0t0  TCP lenovo-ideapad-710s-plus-13ikb.home:41000->162.125.18.133:https (ESTABLISHED)
dropbox    1048 sergio  115u  IPv4 497842      0t0  TCP lenovo-ideapad-710s-plus-13ikb.home:41222->162.125.18.133:https (ESTABLISHED)
dropbox    1048 sergio  120u  IPv4  40148      0t0  UDP *:17500
dropbox    1048 sergio  121u  IPv4 423558      0t0  TCP 192.168.1.78:48700->162.125.68.7:https (CLOSE_WAIT)
dropbox    1048 sergio  145u  IPv4 422843      0t0  TCP 192.168.1.78:52438->ec2-52-20-90-39.compute-1.amazonaws.com:https (CLOSE_WAIT)
dropbox    1048 sergio  149u  IPv4 509467      0t0  TCP lenovo-ideapad-710s-plus-13ikb.home:33326->162.125.68.3:https (CLOSE_WAIT)
dropbox    1048 sergio  150u  IPv4 508921      0t0  TCP lenovo-ideapad-710s-plus-13ikb.home:57450->162.125.33.7:https (CLOSE_WAIT)
code       1318 sergio   43u  IPv4 509251      0t0  TCP localhost:43350 (LISTEN)
chrome    10736 sergio   88u  IPv4 480503      0t0  UDP 224.0.0.251:mdns
```

Los estados de las conexiones puede ser:

- Establish
- Close_wait
- Listen

`fuser 22/tcp` - para conecer que PID estan utilizando un proceso concreto.

`ss` - como vimos anteriormente para visualizar las conexines activa(TUNA):
-t: conexiones tcp
-u: conexiones udp
-n: muestra la ip envez del hostname
-a: muestra los puertos en estucha y los sockets que no estan en escucha.

`nmap` - nos muestra los puertos que esta abierto de una direccion dada. Tiene muchas mas funcionalidades utilizadas en el mundo del hacking pero a nivel del LPCI solo es necesario conocer esta.

```s
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~/GITHUB/LPIC-1   master ●  nmap localhost

Starting Nmap 7.60 ( https://nmap.org ) at 2019-06-26 14:45 CEST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00013s latency).
Not shown: 994 closed ports
PORT     STATE SERVICE
80/tcp   open  http
111/tcp  open  rpcbind
631/tcp  open  ipp
3306/tcp open  mysql
8001/tcp open  vcom-tunnel
8080/tcp open  http-proxy

```

**Ejercicio**

Crear dos usuarios y añadir a uno de ellos al grupo wheel, despues permitir a ese grupo ejecutar como sudo. EL otro usuario debe de tener permisos para reiniciar el servicio web.

```s
sudo useradd -m ssoriano
sudo useradd -G wheel -m jlopez
sudo visudo
```

Vemos en la última linea como al grupo wheel permititos todo (ALL)

```s
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL

## Allows members of the 'sys' group to run networking, software,
## service management apps and more.
# %sys ALL = NETWORKING, SOFTWARE, SERVICES, STORAGE, DELEGATING, PROCESSES, LOCATE, DRIVERS

## Allows people in group wheel to run all commands
%wheel  ALL=(ALL)       ALL
```

Configurar los permisos del administrador de web.

1 Creamos un nuevo fichero de sudoers `/etc/sudoers.d`. Usamos `-f` para crear el fichero.

```s
sudo visudo -f /etc/sudoers.d/web_admin
```

2. Añaidmos la siguiente linea para crear un alias(aliasc command group) que permite ejecutar las ordenes necesarias para reiniciar el servicio de https.

```s
Cmnd_Alias WEB =  /bin/systemctl restart httpd.service, /bin/systemctl reload httpd.service
```

3. Añadimos al fichero la linea `ssoriano ALL=WEB` para permitir que el usuario tenga permiso .

```s
sudo vim /etc/sudoers.d/web_admin
```

Ahora el usuario podra ejecutar reiniciar el servidor web sin embargo no tendra permiso a eso ficheros.

```s
 sudo systemctl restart httpd.service
```

## 110.2 Configuración de la seguridad del sistema

### Securizando intentos accesos locales

Bloquear una cuenta de usuario

```
usermod -L test
```

Cambiamos la fecha de expiracion a 1

```
usermod -e 1 test
```

Comprobamos si esta bloqueada. Al aparecer la exclamación nos indica que la cuenta esta bloqueada.

```
getent shadow test
test:!$6$0cQCrrSa$PdNPFMJB/TtbRVjKErFUpEXBznJMmRXcG9gmON/u1DzmXiVEz5ti1tIn4NopDYbEjat0KcIAfRZoUSAgl6fgx0:18055:0:99999:7:::
```

Comprobamos si tiene acceso a al bash

```
getent passwd test
test:x:1001:1001::/home/test:/bin/sh
```

Modificamos el acceso

```
usermod -s /sbin/nologin test
```

Deshabilitamos la cuenta

```
usermod -U -e "" test
```

Modificamos el fichero de nologin para que cuando un usuario intente entrar se muestre un mensaje

```
vim /etc/nologin
```

### Securizando servicios de red

Vemos los servicios de red que tenemos en escucha

```
losf -i
```

```s
COMMAND   PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
dropbox  1066 sergio   74u  IPv4  48147      0t0  TCP *:db-lsp (LISTEN)
dropbox  1066 sergio   75u  IPv4  31910      0t0  UDP *:17500
```

**COMMAND** - no indica el nombre del servicio
**NAME** - aquí podemos ver desde donde va a permitir las conexiones el puerto que esa en modo escucha, en caso de tener un `*` nos indica que puede recibir conexiones desdes cualquier dirección.

```
service dropbox stop
```

Super-server:
`xinetd` (eXtended InterNET Daemon) ahora conocido como `systemd.socket` , controlan el acceso a los servicios de red.

`TCP Wrappers` - esta funcionalidad utiliza los ficheros **hosts.allow** y/o **hosts.deny** para configurar el acceso a los servicios de red.

`systemd.socket` - es utilizado para activar servicios de red bajo demanda. En vez de utilizar el servicio(por ejemplo ssh.server) utilizara sshd.socket. De esta manera el servicio solo se arranca bajo demanda, en vez de estar a la escucha en todo momento. Las unidades de Socket solo permiten el acceso al servicios de red cuando una conexion entrante la solicita.

### Ejercicio

Para que el servicio de ssh no este siempre a la escucha, deshabilita el servicio y activa el socket.

Comprobamos el estado del servicio

```s
systemctl status sshd.service
```

Activamos en el arranque el socket y deshabilitamos el servicio.

```s
sudo systemctl enable sshd.socket
sudo systemctl disable sshd.service
```

## 110.3 Protección de datos mediante cifrado

### GPG

GPG (GNU Privacity Guard) - Herramienta de cifrado y firmas digitales desarrollada por Werner Koch bajo la licencia GPL. Es el reemplazo de PGP(Pretty Good Privacity)

GPG utiliza el estándar del IETF denominado [OpenPGP](https://www.openpgp.org/about/standard/)

[Firma digital](https://www.gnupg.org/gph/es/manual/x154.html)

`~/.gnupg` - directorio donde podemos encontrar las claves de anillo y la configuracion de las claves gpg de cada usuario.

`gpg --gen-key` - para generar la calve

Exportamos la clave pública:

Nos tenemos que ubicar en el directorio donde están guardadas las claves.

```s
cd ~/.gnupg
gpg -o demopublic --export C7D4EF00D70FBCC7D25170BA7950F49D0650C39D
```

Es importante generar la clave de revocación para cancelar el certificado en caso de que nuestra clave se vea comprometida.

Para publicar publicar la clave publica en los servidores de pgp

```s
gpg --keyserver pgp.mit.edu --send-keys C7D4EF00D70FBCC7D25170BA7950F49D0650C39D
```

<hr>
Cosas a tener en cuenta:

- Si queremos enviar un mensaje encriptado a otra persona, necesitamos su clave pública, se _encriptan_ con la clave pública del destinatario para que solo el lo pueda _desencriptar_ con su clave privada.
- Si queremos firmar un documento o archivo para demostrar que es nuestro, lo debemos firmamos con nuestra clave privada. Cualquier persona puede comprobar que ha sido firmado por mi utilizando mi clave pública y demostrar que no ha sido modificado.

## SSH

Podemos ver los ficheros de configuración en `/etc/ssh`.

`sshd_config` - fichero de configuración para las conexiones ssh.

`sh-keygen` - comando para generar un par de claves asimetricas.

Todos los usuarios tienen un fichero de configuración individual en ~/.ssh.

Cuando nos conectamos por primera vez a un servidor se crea un fichero llamado `known_hosts` que contiene la claves públicas de los servidores conocidos.

Podemos crear un par de claves asimetricas para conectarnos sin contraseña. De esta forma solo podra conectarse los propietarios de estas claves.

1. Creamos el par de claves

```s
ssh-keygen
```

Nos creará 2 claves 1 pública y una privada. Tenemos que copiar la clave publica en el equipo **remoto**. Con el comando `ssh-cooy-id` copiaremos la clave publica en el equipo remoto.Mas info [aquí](https://www.ssh.com/ssh/copy-id#sec-Copy-the-key-to-a-server).

Este comando copiará la clave pública en el fichero `~/.ssh/authorized_keys` que contrendrá las claves publicas que puede aceptar para que un usuario remote se conecte al servidor.

```s
ssh-copy-id -i miclave sergio@107.174.218.90
```

`ssh-agent bash` - un agente que sirve para automatizar el acceso sin necesidad de introducir la passphrase.

`ssh-add claveprivada` para añadir la passphrase de nuestra clave privada.

`ssh -x` - Deshabilitar las conexiones por ssh para entornos X11

`ssh -X` - Habilitar las conexiones por ssh para entornos X11

Para conectarnos con la opción de mostrar las ventanas remotas en nuestro equipo.

```s
ssh -Y sergio@192.168.0.202
```
