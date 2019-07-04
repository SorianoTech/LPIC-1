# 107: Tareas Administrativas

## 107.1 Administrar cuentas de usuario y de grupo y los archivos de sistema relacionados con ellas

### Añadir y eliminar usuarios

`useradd`

```console
sudo useradd -m name
```

Usamos `-m` para crear el home del usuario.
En algunas distribuciones no es necesario utilizar -m, ya que crean automáticamente la carpeta.

Creamos un usuario que utilice una shell diferente.

```console
sudo  useradd -m -c "Juanjo Garcia" -s /bin/tcsh \ juanjo
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

### Añadir y eliminar grupos

`groups` - comando para conocer los grupos primarios y secundarios de los que forma parte el usuario.

`groupadd` - añade un nuevo grupo.

Creamos un grupo legal y creamos un usuario y lo añadimos a ese grupo.

```s
sudo groupadd legal
sudo useradd -G legal -m -c "Mario Gonzalez" \ mgonzalez
```

`groupdel` - comando para borrar un grupo.

### Usuarios y configuración de ficheros de grupo

`/etc/passwd` - fichero que contiene las cuentas de usuario del sistema.

Las columnas se separan por el carácter `:` y cada una de las columnas significa:

1. Nombre de usuario
2. X password encriptado
3. User id (las cuentas por encima de un id 1000 son cuentas de usuario "normales")
4. Primary Group id
   5 .User id info
5. Directorio del home de usuario
6. bash que utiliza el usuario (si no ha iniciado sesion aparecera nologin)

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

Si una cuenta tiene en la segunda columna los caracteres de `!!` significa que esta bloqueada.

`/etc/group` - fichero que contiene información sobre los grupos de usuarios.

1. Nombre del grupo
2. Password del grupo.
3. ID del grupo.
4. los usuarios que forman parte del grupo.

---

### Modificaciones de usuarios y grupos

`usermod` - este comando se utiliza para modificar configuraciones de usuarios ya existentes.

`change` - este comando puede listar y modificar los parámetros de expiración de password y expiración de la cuenta de usuario.

`groupmod` - modifica los atributos de un grupos, como el nombre o ID.

`getent passwd sergio` - muestra información de las bases de datos del sistema. [Enlace](https://www.unixtutorial.org/commands/getent)

---

#### Ejercicios

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

## 107.2 Automatizar tareas administrativas del sistema mediante la programación de trabajos

### CRON

Lo utilizamos para programar tareas que van a ser ejecutadas en periodos de tiempo que nosotros decidamos.

`contrab -e` - para modificar el fichero de cron.

`/etc/crontab` - fichero con los trabajos programados del sistemas

`/etc/cron.d/` - directorio que contiene los trabajos progrmados del sistema. se crea un fichero por cada tarea añadida.

1. Minutos
2. Horas
3. Dia del mes (podemos usar \* para indicar que no importa el dia que sea)
4. Mes (\* si no nos importa el mes).
5. Dia de la semana(sat, para que se ejecute los sábados).
6. Username(el usuario que ejecuta la tarea).
7. La tarea que queremos que ejecute.

[Ejemplos](http://researchhubs.com/post/computing/linux-cmd/awesome-crontab-job-examples.html)

Los ficheros de las configuracion de cada uno de los usuarios son creados en:

`sudo cat /var/spool/cron/crontabs/sergio`

Podemos utilizar `crontab -l` para ver las tareas programadas del usuario.

Para borrar el contenido el fichero de cron usamos el comando `crontab -r`.

Si queremos borrar el de un usuario:

`crontab -r -u sergio`

Podemos bloquear a un usuario para que no pueda crear cron añadiendolo al fichero `/etc/cron.denny`

### At

Se utiliza para ejecutar una tarea en un determinado momento, al contrario de cron que sirve para programar de una forma repetitiva.

> Por defecto no suele venir instalada en las distribuciones Linux

Programamos una tarea para que se ejecute dentro de 5 minutos para que cre un fichero llamado notes.txt con el contenido pasado con echo:

`atq` - sirve para ver las tareas programadas.

```
at now + 5 minutes
warning: commands will be executed using /bin/sh
at> echo "Notas para luego:" > /home/sergio/notes.txt
at> <EOT>
job 1 at Sat Jun  8 16:16:00 2019
 sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  atq
1	Sat Jun  8 16:16:00 2019 a sergio
```

`atrm` - sirve para eliminar una tarea programada, indicando el numero.

Programar una tarea que ejecute un script en un determinado momento.

```
at -f /root/program.sh 10:15 PM Jul 8
```

Es posible configurar que usuarios pueden utilizar la herramienta `at`, añadiendolos al fichero `at.allow` o denegandolos en `at.deny`.

### Systemd Timer Unit Files

Es un timer controlado por systemd, utilizado en los nuevos sistemas para controlar las tareas repetitivas.

Cada fichero **.timer** tiene que tiener un fichero **.service**, por ejemplo si tienes un fichero foo.timer tienes que tener un fichero foo.service.

Hay dos tipos de timer:

- Monotonic - OnBootSex=, OnActiveSec=
- Realtime - OnCalendar

Se utiliza mas por que la sintaxis es mas sencilla.

Timer unit file:

- [Unit]
- [Timer]
- [Install]

Manuales:

- man 5 systemd.timer
- man 7 systemd.timer

Para ver los timers que tenemos configurado en el sistema y los servicios que tiene asociales:

`systemctl list-timers --all`

```console
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  systemctl list-timers --all
NEXT                          LEFT          LAST                          PASSED     UNIT                         ACTIVATES
Sat 2019-06-08 17:01:21 CEST  13min left    Sat 2019-06-08 16:02:27 CEST  45min ago  anacron.timer                anacron.service
Sat 2019-06-08 17:09:00 CEST  21min left    Sat 2019-06-08 16:39:09 CEST  8min ago   phpsessionclean.timer        phpsessionclean.service
Sat 2019-06-08 20:29:41 CEST  3h 42min left Sat 2019-06-08 09:32:35 CEST  7h ago     apt-daily.timer              apt-daily.service
Sun 2019-06-09 01:30:57 CEST  8h left       Fri 2019-06-07 19:42:44 CEST  21h ago    motd-news.timer              motd-news.service
Sun 2019-06-09 06:50:37 CEST  14h left      Sat 2019-06-08 09:32:35 CEST  7h ago     apt-daily-upgrade.timer      apt-daily-upgrade.service
Sun 2019-06-09 12:29:09 CEST  19h left      Fri 2019-06-07 19:27:44 CEST  21h ago    systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
Mon 2019-06-10 00:00:00 CEST  1 day 7h left Mon 2019-06-03 00:27:52 CEST  5 days ago fstrim.timer                 fstrim.service
n/a                           n/a           n/a                           n/a        snapd.snap-repair.timer      snapd.snap-repair.service
n/a                           n/a           Fri 2019-06-07 19:13:37 CEST  21h ago    ureadahead-stop.timer        ureadahead-stop.service
```

`systemctl cat anacron.timer`

Podemos ver la descripción, el momento de ejecución y el apartado install.

```console
sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  systemctl cat anacron.timer
# /lib/systemd/system/anacron.timer
[Unit]
Description=Trigger anacron every hour

[Timer]
OnCalendar=hourly
RandomizedDelaySec=5m
Persistent=true

[Install]
WantedBy=timers.target
```

`system-ctl cat anacron.service`

También podemos crear un timer que no requere un fichero `.service` ejecutado:

`systemd-run --on-active=1m /bin/touch /home/sergio/hello`

## 107.3 Localización e internacionalización

### Trabajando con la localizacion del sistema

`locale` - comando para mostrar la información de configuracion del lenguaje del sistema.

`localectl` - comando para configurar el idioma por defecto y el lenguaje del sistema.

Podemos mostrar la lista de idiomas con:

`localectl list-locales`

`iconv` - utilidad usada para convertir ficheros de un tipo de codificación a otro.

> UTF-8 es el sistema de caracetes codificados más utilizado.

Para cambiar el idioma, podemos cambiar la variable entorno `LANG`

`LANG=pl_PL.utf8`

`LANG=C`

### Hora y fecha en los sitemas Linux

`date` - muestra información sobre la fecha actual. Podemos utilizar valores para formatear la salida por pantalla en diferentes formatos. Es intereante conocer formatear la salida de la fecha a la hora de utilizar scripts.

```console
 sergio@Lenovo-ideapad-710S-Plus-13IKB  ~  date +%m/%d/%Y
06/08/2019
```

`timedatectl` - muestra la hora actual del sistema y la del hardware (RTC clock).

Mostramos la lista de horarios disponibles y cabiamos a "Antartica/davis".

```
timedatectl list-timezones
timedatectl set-timezone "Antartica/Davis"
```

`tzselect` - comando para seleccionar por menu la zona horaria que queremos.

`/etc/localtime` - fichero para distribuciones REDHAT.
`/etc/timezone` - fichero para distribuciones DEBIAN.
`/usr/share/zoneinfo` - directorio que contiene todas las zonas dispoibles que el equipo puede configurar.
