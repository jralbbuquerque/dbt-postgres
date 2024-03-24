# Imagem padrão utilizada para a construção da imagem
FROM python:3.8.3-slim

# Copia todos os códigos e artefatos para o container
COPY . /app

# Define a área de trabalho sendo o diretório /app
WORKDIR /app

RUN apt-get update \
    && apt-get -y install libpq-dev gcc

# Instala as dependencias
RUN pip install -r ./requirements.txt

# Executa o script para criar os objetos no banco de dados
CMD python scripts/build-db.py