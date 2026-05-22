
# Parte 1 - Containers

1. Rodando o ubuntu
```shell
docker container ls
docker run ubuntu
docker container ls
docker container ls -a
```

2. Removendo um container
```shell
docker container rm ID|NAME
```

3. Criando container com nome
```shell
docker run --name my-ubuntu ubuntu
docker container rm ID|NAME
```

4. Criando container com nome e acessando ele diretamente
```shell
docker run --name my-ubuntu -it ubuntu
ls
rm -rf *
ls
exit
docker container rm ID|NAME
```

5. Criando pequena aplicação python

```shell
docker run --name my-ubuntu -it ubuntu
python # não existe
python3 # não existe
apt update
apt install python3
apt install nano
nano main.py
print('Hello World!')
CTRL+O # salvar
Enter # confirmar
CTRL+X # sair
python3 main.py
```

# Parte 2 - Imagens

1. Listar imagens. Vai aparecer 
* O nome da imagem que é formado pelo prefixo:tag
* ID da imagem
* Uso de disco

```shell
docker image ls
```

2. Acessar Dockerhub e verificar imagens disponíveis.

    https://hub.docker.com/

3. Baixar uma imagem python prédefinida e rodar um container sobre ela criando uma aplicação python.

```shell
docker pull python:3.12
docker run --name my-python -it python:3.12
docker run --name my-python -it python:3.12 bash
apt update && apt install nano
nano main.py
print('Hello World!')
CTRL+O # salvar
Enter # confirmar
CTRL+X # sair
python main.py
```

4. Criar imagens personalizadas com Dockerfile

Criamos um arquivo `Dockerfile`

```Dockerfile
FROM python:3.12

RUN apt update
RUN apt install nano
# compact: RUN apt update && apt install nano

RUN pip install Flask
```

Fazemos o build dele
```shell
docker build -f Dockerfile -t my-personal-python:dev .
```

Rodamos um container com ele
```shell
docker run --name my-python -it my-personal-python:dev bash
nano main.py
print('Hello World!')
CTRL+O # salvar
Enter # confirmar
CTRL+X # sair
python main.py
```

# Parte 3 - Volumes

1. Rodando container com mapeamento de pasta
```shell
docker run --name my-python -v ./app:/app -it my-personal-python:dev bash
```

# Parte 4 - Portas

# Parte 5 - Docker Compose

# Parte 6 - Aplicação