MEANDO
======

MEAN Stack on Digital Ocean with Vagrant. MEANDO

OK, primero lo describiré en español y después, si veo que le interesa a la gente lo traduciré al Inglés.

INSTRUCCIONES
======

Primero que nada, hay que tener instalado Vagrant:

http://www.vagrantup.com/

Después, vamos a hacer clone a este repositorio:

```sh
git clone https://github.com/ocruzv/MEANDO.git
```

Una vez teniendo todo, vamos a ir a nuestra consola y navegamos a la carpeta en donde hicimos el clone.

Editamos nuestro archivo "Vagrantfile".

Buscamos las líneas que contienen:

```ruby
provider.client_id = 'DIGITALOCEAN_CLIENTID' 
provider.api_key = 'DIGITALOCEAN_APIKEY'
```

Obviamente, estas las vamos a sustituir por las claves que nos da DigitalOcean en su panel de administración en la sección de "API". Si no nos da la API Key, generamos una nueva.

Guardamos el archivo Vagrantfile, y comenzamos a hacer la magia. En consola ejecutamos:

```sh
$ vagrant plugin install vagrant-digitalocean
$ vagrant plugin install vagrant-omnibus
$ vagrant up --provider=digital_ocean
```

Posibles Errores
======

Si nos marca error de SSL o RSA, esta puede ser una solución. Sacado desde el Github de @smdahlen/vagrant-digitalocean

```
NOTE: If you are using a Mac, you may need to install a CA bundle to enable SSL communication with the Digital Ocean API. It is recommended to first install Homebrew. With Homebrew installed, run the following command to install the bundle:

$ brew install curl-ca-bundle

Once the bundle is installed, add the following environment variable to your .bash_profile script and source it:

export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
```

Si no tenemos Mac, entonces nuestro error puede ser que no tenemos claves SSL creadas, lo creamos desde linux con el siguiente comando estando en la carpeta ~/.ssh:

```sh
$ ssh-keygen -t rsa -C "your@email.com"
```

Y siguen las instrucciones que aparezcan en pantalla
============

Si nos marca error de rsync, lo primero que tenemos que hacer es acceder a nuestra máquina mediante ssh:

```sh
$ vagrant ssh
```

Una vez dentro del ssh de nuestro droplet, instalamos rsync:

```sh
$ sudo yum install rsync
```

Para salirnos del ssh simplemente ejecutamos:

```sh
$ exit
```

===========

Una vez corregidos los posibles errores, volvemos a hacer:

```sh
$ vagrant up --provider=digital_ocean
```

Si aún así, cuando accedemos a nuestra IP no nos aparece la página por defecto de nginx, ejecutamos lo siguiente:

```sh
$ vagrant provision
```

Una vez que termine de hacer todo lo que tiene que hacer, accedemos a nuestro servidor mediante la IP que DigitalOcean nos proporciona para nuestro droplet en el panel de administración y nos debe mostrar la pantalla por default de Nginx.

SSH
======

Para acceder por ssh a nuestro servidor, simplemente ejecutamos:

```sh
vagrant ssh
```

Para salirnos del ssh simplemente ejecutamos:

```sh
$ exit
```

Node.JS
======

Nuestro Stack MEANDO está configurado para hacer un reverse proxy a Node.JS, siempre y cuando nuestra app la ejecutemos en el server en el puerto 15301.

Para modificar el dominio o host mediante el que se accede a la app en Node.js, podemos modificar el archivo

```sh
nano /etc/nginx/sites-available/node.js
```

Dentro de nuestro Droplet de DigitalOcean.

Comandos soportados de Vagrant
======

The provider supports the following Vagrant sub-commands:
```
vagrant destroy - Destroys the droplet instance.
vagrant ssh - Logs into the droplet instance using the configured user account.
vagrant halt - Powers off the droplet instance.
vagrant provision - Runs the configured provisioners and rsyncs any specified config.vm.synced_folder.
vagrant reload - Reboots the droplet instance.
vagrant rebuild - Destroys the droplet instance and recreates it with the same IP address is was assigned to previously.
vagrant status - Outputs the status (active, off, not created) for the droplet instance.
```