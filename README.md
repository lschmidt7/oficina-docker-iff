
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

Com volumes conseguimos mapear pastas do nosso sistema para dentro de uma pasta no container, o que acontecer dentro dessa pasta no host, reflete no container e o que acontecer no container, reflete no host.

1. Rodando container com mapeamento de pasta
```shell
docker run --name my-python -v ./code:/app -it my-personal-python:dev bash
```

# Parte 4 - Portas

Nessa etapa vamos aprender a redirecionar uma porta de rede do host para o container

1. Criar um server em python com flask

`server.py`
```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Olá, Flask!"

if __name__ == "__main__":
    app.run('0.0.0.0', debug=True)
```

2. Criar uma um Dockerfile do python com flask

```Dockerfile
FROM python:3.12

RUN apt update

RUN pip install Flask
```

3. Crie a imagem Docker

```bash
docker build -f .\Dockerfile.server -t python-flask:dev .
```

4. Rodar o server com volume da pasta do código
```shell
docker run --name my-python-server -v ./code:/app -it python-flask:dev bash
```

5. Rodar o server com volume da pasta do código e com redirecionamento de porta
-p PORTA_HOST:PORTA_CONTAINER

```shell
docker run --name my-python-server -v ./code:/app -p 5000:5000 -it python-flask:dev bash
```

5. Teste diferentes portas do host para a porta 5000 do server

```bash
docker run --name my-python-server -v ./code:/app -p 8085:5000 -it python-flask:dev bash
```

# Parte 5 - Docker Compose

Agora vamos automatizar tudo que vimos rodando nosso server diretamente de um compose file do docker em formato yml

`docker-compose.yml`
```docker
services:
  my-python-server:
    container_name: my-python-server
    image: python-flask:dev
    working_dir: /app
    volumes:
      - ./code:/app
    command: ["/bin/bash", "-c", "python server.py"]
    ports:
      - 8050:5000
```

# Parte 6 - Próximos passos

    * Desenvolvimento em container
    * IPC
    * Networks
    * Named Volumes
    * Restart policies
    * Enviroment variables
    * healthcheck
    * depend_on
    * runtime
    * initialization with wait-for method

# Tips

* docker desktop -> settings -> wsl integration