## Julia

Página del grupo "Julia" de Teoria del Lenguaje de la Facultad de Ingeniería de la Universidad de Buenos Aires.


### Temas Oficiales del grupo
 - [Tema tranca](https://open.spotify.com/track/5FnpXVgDOk2sLT58qM22Of)
 - [Tema festivo](https://open.spotify.com/track/4JUu9vPnWQXEU9BCUQvqC6)

### Tutoriales
 - [Video que repasa todos los features](https://www.youtube.com/watch?time_continue=1&v=4igzy3bGVkQ)
 - [Notebook para probar](https://next.juliabox.com/)

### Levantar Jupyter

#### Instalar 
 -  docker

#### Agregar nuestro usuario al grupo docker
```
sudo usermod -aG docker $USER (reinciar la maquina, si, reiniciar)
```
#### Correr imagen de prueba
```
docker run hello-world
```
#### Traer la imagen de jupyter
```
docker pull jupyter/datascience-notebook
```
#### Levantar la imagen (Opción 1)
```
docker run  -p 8888:8888 jupyter/datascience-notebook 
```
#### Levantar la imagen mapeando un directorio (Opción 2)
```
docker run -v /home/hostfolder:/home/jovyan/work/imagefolder -p 8888:8888 jupyter/datascience-notebook 
```


### Observaciones
You can use the [editor on GitHub](https://github.com/pablito-ernesto/julia/edit/master/README.md) to maintain and preview the content for your website in Markdown files.
