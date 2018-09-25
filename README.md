## Julia

Página del grupo "Julia" de Teoria del Lenguaje de la Facultad de Ingeniería de la Universidad de Buenos Aires.


### Tema Oficial del grupo

### Levantar Jupyter

#### instalar 
 -  docker

#### Agregar nuestro usuario al grupo docker
´´´
sudo usermod -aG docker $USER (reinciar la maquina, si, reiniciar)
´´´
#### Correr imagen de prueba
´´´
docker run hello-world
´´´
#### Traer la imagen de jupiter
´´´
docker pull jupyter/datascience-notebook
´´´
#### Levantar la imagen 
´´´
docker run  -p 8888:8888 jupyter/datascience-notebook 
´´´
#### Levantar la imagen mapeando un directorio
´´´
docker run -v /home/pablo/desa/src/personal/julia/tutorials:/home/jovyan/work/tutorials -p 8888:8888 jupyter/datascience-notebook 
´´´


### Observaciones
You can use the [editor on GitHub](https://github.com/pablito-ernesto/julia/edit/master/README.md) to maintain and preview the content for your website in Markdown files.
