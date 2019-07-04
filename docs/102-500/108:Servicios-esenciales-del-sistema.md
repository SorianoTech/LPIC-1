# Tema 108: Servicios esenciales del sistema

## 108.1 Mantener la hora del sistema

Tenemos que saber como configurar nuestro equipo para recibir la hora de un servidor de NTP.

### Trabajando con servidores remotos de tiempo(NTP)

**NTP** - Network Time Protocol

:Capas del protocolo
Stratum 0  
 Stratum 1
Stratum 2

`ntpd` - es el demonio(servicio) que comprueba contra el servidor de ntp para comprobar si la hora es correcta.

`ntpdate` - comando para recibir la hora de un servidor de ntp especifico, es necesario que el servicio no este corriendo.

`/etc/ntp.conf/` - fichero de configuracion para el demonio de ntpd.

`ntpq` - comando para realizar una query al demonio **ntpd**.

`timedatectl` - comando para comprobar la configuración del servidor ntp

`chronyd` - es el demonio moderno que los equipos que utilizan **systemd**.

`/etc/chrony/chrony.conf` - fichero de configuración al igual que el antiguo fichero `ntp.conf`.

`chronyc` - comando para consultar la información del demonio **chronyd**.

## 108.2 Registros del sistema

## Sistemas de Logs antiguaos

`/var/log/dmesg` - logs relacionadios con el hardware, consultar en caso de tener problemas con los dispositivos conectados. Se crea cada vez que el sistema arranca.(Linux kernel boot messages).

`/var/log/messages` - log que recoje los problemas con los servicios.

`/var/log/secure` - contiene información de los accesos de los usuarios.

`/var/log/maillog` - contiene información del servidor de correo.

Todos estos logs son gestionados por el antiguo demonio **rsyslog**. (En los sistemas que no utilizan **systemd**).

**Niveles de prioridad de Logs**

![Log Priority](img/loggin_priority.png)

**Niveles de logs Facilities**

![Loggin Facilities](img/log_facilities.png)

Podemos ver esta información con el comando:

`dmesg -x`

`logger` - comando que puede ser utilizado para enviar informacion al fichero **/etc/log/messages**.

### Rsyslog

Utilizado en distribuciones anteriores a Centos 7.

`rsyslog` - la configuracion del demonio la podemos encontrar en **/etc/rsyslog.conf**.

Los ficheros de ayuda esta escritos en html y necesitamos lynx:

> yum -y install lynx

Es posibble configurar rsyslog para enviar los log a un servidor remoto.

`/etc/logrotate.conf` - es el fichero de configuración del demonio lograte, encargado de manejar el tamaño y la rotación de los ficheros de log.

`/etc/logrotate.d/` - Configuración avanzanda para que otros demonios puedan

`logrotate` - comando para rotar los ficheros de configuración.

### Introduccion al diario de systemd

Recoge los log de :

- Logs del Kernel
- Logs del sistema
- Servicios del sistem que envian salidas de (standar ouput y standard error)

La ruta por defecto esta en `/run/log/journal` esta informacion se pierde despues de cada reinicio.

Para hacerla permanente teemos que hacer:

```console
mkdir -p /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
```

Podemos encontrar mas informacion sobre la condiguración en:

> man 5 journald.conf

El fichero de configuracion se encuentra en `/etc/systemd/journald.conf`

### journalctl

Los sistemas que usan systemd utilizan el comando journalctl(Journal control) para obtener informacion del demonio de logs systemd journal(systemd-journald.service).

`journalctl -n 20` - muestra las entradas mas recientes y limita la salida a 20.

`journalctl -f -u httpd.service` - nos muestra los log de un servicio en particular.

`journalctl -o verbose` - para mostrar todos los log de una forma ordenada.

`journalctl -o json-pretty` - para ver los log en formato json, la salida puede ser tratada para mostrarla en una web por ejemplo. Muy util para analizar los datos.

`systemd-cat` - para enviar una salida de texto al diario de logs.

#### **Demo:**

Tenemos un problema con el servidor web de apache.

Nos logamos como root

`sudo su -`

Comprobamos el estado del servicio:

`systemctl status httpd.service`

Intentamos arrancar el servidor web

`systemctl start httpd.service`

Tras comprobar que no arranca, buscamos en el log.

`journalctl -u httpd.service`

Vemos que nos indica que no puede encontrar el fichero de configuración.

```console
journalctl -u httpd.service
-- Logs begin at Sun 2019-06-09 04:33:02 EDT, end at Sun 2019-06-09 04:46:20 EDT. --
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal systemd[1]: Starting The Apache HTTP Server...
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal httpd[13571]: httpd: Could not open configuration file /etc/httpd/conf/httpd.conf: No such file
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal systemd[1]: httpd.service: main process exited, code=exited, status=1/FAILURE
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal kill[13572]: kill: cannot find process ""
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal systemd[1]: httpd.service: control process exited, code=exited status=1
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal systemd[1]: Failed to start The Apache HTTP Server.
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal systemd[1]: Unit httpd.service entered failed state.
Jun 09 04:45:18 ip-10-0-1-160.ec2.internal systemd[1]: httpd.service failed.
```

Comprobamos si el directorio de configuracion contiene el fichero.

`ls /etc/httpd/conf`

Restauramos el fichero de configuracion

`mv /etc/httpd/conf/httpd.conf.bkup /etc/httpd/conf/httpd.conf`

Reiniciamos el servicio

`systemctl restart httpd.service`

Comprobamos que el servicio esta corriendo correctamente

`systemctl status httpd.service`

utilizamos elinks para comprar que el sitio funciona correctamte

`elinks http://localhost`

#### Demo 2

Queremos programar un backup de una pagina web. Tenemos escrito el scrip que realiza la tarea llamadao `web-backup.sh` y queremos que se ejecute diariamente.

1. Creamos es el scrip
2. Creamos el fichero web-backup.service (especifica que va hacer)
3. Creamos el fichero web-backup.timer (indica cuando se va a ejecutar y por quien)

4. Copiamos el contenido del script a `usr/local/sbin/`

`cp web-backup.sh /usr/local/sbin/`

Y damos permisos de ejecucion sobre el script

`chmod +x /usr/local/sbin/web-backup.sh`

5. Copiamos los ficheros de servicio y timer a `/etc/systemd/system`

`cp web-backup.{service,timer} /etc/systemd/system/

6. Reiniciamos el demonio de systemd

`systemctl daemon-reload`

7. Habilitamos el servicio para que se ejecute al arrancar el sistema.

`systemctl enable web-backup.timer web-backup.service`

> Esto creara los enlaces simbolicos necesarios.

8. Arrancamos los servicios.

`systemctl start web-backup.timer web-backup.service`

9. Comprobamos los servicios

```
systemctl status web-backup.timer
systemctl status web-backup.service
```

## 108.3 Mail Transfer Agent (MTA) Fundamentos

MTA -> MDA (Port 25 TCP) -> MUA

- **MTA**: Mail Transfer Agent
- **MDA**: Mail delivery Agent
- **MUA**: Mail user agent

Conocer el sistema de MTA es el importante para el examen.

Sistemas de MTA más comunes:

`Sendmail` - es el sistema de mta mas antiguo, es difil de configurar y suele venir instalado por defecto en la mayoria de distribuciones de linux.
`Postfix` - es el MTA moderno encontrado en muchas de las distribuciones de linux, es fácil de configurar y tiene una buena segurida.
`Exim` - es el sistema de MTA por defecto en las distribuciones Deabian, tiene una buena seguridad y es mas sencillo de configurar que Sendmail.

`Send Emulation Layer` - los administradores pueden utilizar los comandos de 'sendmail' en otras MTA (Postfix, Exim,etc) como si estuvieran utilizando la instalacion de Sendmail.

### Renvio de Email y Alias

Los alias se utilizan para que utilizando otro nombre se envie a la cuenta que queramos, por ejemplo si tenemos un buzon que se llama sergio@localhost podemos crear un alias para que los correos que se envien a **yo@localhost`** se reciban en el buzón de sergio@localhost

`/etc/aliases` - es el fichero de configuracion que se utiliza para realizar el renvio de correos entre usuarios.

`newaliases` - comando que es necesario lanzar despues de modificar el fichero anterior para que se enere el fichero `/etc/aliases.db` fichero que el MTA usa para entregar los correos.

Para enviar un correo desde la terminal con postfix

`mail -s "Este es un mensaje" sergio@localhost`

Comprobamos la mandeja de entrada:

`mail` - comando para enviar los correos o para ver los correos de un usuario.

`mailq` - comando para ver los correos que estan encolados, esperando a ser enviados a su destino. En sendmail se usaba `sendmail -bp`.

`~/.forward` - un fichero de configuracion que puede ser colocado en el home del usuario para reenviar correos que sean enviados a el y quieran ser enviados a otro usuario o email externo. (solo tenemos que especificar el usuario o el correo en este fichero). [Ejemplo](https://www.ccsf.edu/Pub/UNIXhelp/mail/file_forward.html)

Log del email

`/var/log/maillog/`

#### DEMO:

Configurar el servidor de correo para que reenvie todos los correos que llevan a root al usuario cloud_user.

1. Nos logamos con el usuario root

`sudo su -`

2. Añadimos el alias en el fichero `/etc/aliases`.

`echo "root: cloud_user" >> /etc/aliases`

3. Regeneramos la base de datos de los alias

`newaliases`

4. Enviamos un mensaje de prueba

`mail -s "Probando" -a "/etc/services" root@localhost < /dev/null`

5. Salimos de la sesion de root

`exit`

6. Comprobaoms la badejande entrada

`mail`

```console
[cloud_user@ip-10-0-1-208 ~]$ mail
Heirloom Mail version 12.5 7/5/10.  Type ? for help.
"/var/spool/mail/cloud_user": 6 messages 6 new
>N  1 root                  Fri Jun 14 03:06 11204/671277 "Probando"
 N  2 Mail Delivery System  Fri Jun 14 03:14  73/2622  "Undelivered Mail Returned to Sender"
 N  3 root                  Fri Jun 14 03:20 11204/671259 "Probando"
 N  4 root                  Fri Jun 14 03:22 11204/671259 "Probando"
 N  5 root                  Fri Jun 14 03:24 11204/671259 "Probando"
 N  6 root                  Fri Jun 14 03:25 11204/671259 "Probando"
& 1
Message  1:
```

```
Jun 14 03:25:51 ip-10-0-1-208 postfix/local[4784]: 32C0D43D376: to=<cloud_user@ip-10-0-1-208.ec2.internal>, orig_to=<root@localhost>, relay=local, delay=0.05, delays=0.03/0/0/0.02, dsn=2.0.0, status=sent (delivered to mailbox)
Jun 14 03:25:51 ip-10-0-1-208 postfix/qmgr[4144]: 32C0D43D376: removed
```

## 108.4 Gestión de la impresión y de las impresoras

### The Common Unix Printing System (CUPS)

Instalamos el CUPS driver y el servidor de impresion en ubuntu. Esto nos facilita el manejo mediante un frontal web para administrar las impresoras.

`sudo apt-get install cups printer-driver-cups-pdf`

1. Eliminamos la impresora que viene por defecto(Imprime en PDF), haciendo click en Administración -> Manage Printer -> PDF , seleccionamos en el desplegable de Administration -> Delete.

2. Al terminar de configurarla tenemos que seleccionar que sea la impresora por defecto.

`/etc/cups` - directorio que contiene los ficheros de configuracion del servidor de CUPS.

`/etc/cups/printers.conf` - fichero de configuración de las impresoras, no se debe cambiar cuando el servidor CUPS esta arrancado.

Cargamos la web de administracion de impresión:

`http://localhost:631`

### The Line Print Daemon

Es el domonio de impresión antiguo(legacy)

> El puerto socket para las impresoras es el **9100**

`lpd` - Line Print Daemon

`lpstat` Muestra el estado del servidor de CUPS, las impresoras configuradas y las colas de impresión.

`lpadmin` - herramienta para añadir, modificar y eliminar impresoras.

`lpinfo` - este comando muestra las impresoras disponibles y los drivers que pueden usar.

`lpc` - antiguo comando para mostrar informacion sobre las impresoras.

`lpr` - este comando envia a imprimir el fichero que se indique a la impresora por defecto.

Imprime el fichero de usuarios:

```
lpr /etc/passwd/
```

`lpq` - este comando muestr las colas de impresion del servidor CUPS. Con la opción -a vemos todas las colas de impresion.

`lprm` - sirve para eliminar un trabajo que exista en la cola de impresión indicando el PID:
