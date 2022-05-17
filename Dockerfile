# base image
# a little overkill but need it to install dot cli for dtreeviz
FROM ubuntu:18.04

# ubuntu installing - python, pip, graphviz, nano, libpq (for psycopg2)
RUN apt-get update &&\
    apt-get install python3.9 -y &&\
    apt-get install python3-pip -y &&\
    apt-get install graphviz -y &&\
    apt-get install nano -y

# exposing default port for streamlit
EXPOSE 80 443

# making directory of app
WORKDIR /streamlit-docker

# copy over requirements
COPY requirements.txt ./requirements.txt

# installing required packages
RUN pip3 install -r requirements.txt

# copying all app files to image
COPY . .

# cmd to launch app when container is run
CMD python3 scripts/load_docker_db.py
CMD streamlit run app.py

# streamlit-specific commands for config
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN mkdir -p /root/.streamlit

RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > /root/.streamlit/credentials.toml'

RUN cp .streamlit/config.prod.toml /root/.streamlit/config.toml

# RUN bash -c 'echo -e "\
# [server]\n\
# enableCORS = false\n\
# " > /root/.streamlit/config.toml'