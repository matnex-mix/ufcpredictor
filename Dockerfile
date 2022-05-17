FROM marcskovmadsen/awesome-streamlit_base:latest

WORKDIR /app
ADD . ./

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt \
    && rm -rf requirements.txt

# Default port for Azure Web App for containers is 80
# Please note that port and serverPort in the config.toml file
# should correspond to the exposed port
EXPOSE 80 443

RUN mkdir ~/.streamlit
RUN cp .streamlit/config.prod.toml ~/.streamlit/config.toml
# RUN cp .streamlit/credentials.prod.toml ~/.streamlit/credentials.toml
# RUN cp config.prod.py config.py
RUN invoke sphinx.copy-from-project-root
WORKDIR /app

ENTRYPOINT [ "/bin/bash", "./scripts/run_awesome_streamlit_with_ping.sh"]