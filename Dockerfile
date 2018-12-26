##########################################################
# 
# Modified from pydicom/deid to use pandas and Jupyter notebooks
# Goal is to create a Dockerized de-id pipeline.
#
# Po-Hao Chen 2018
#
##########################################################

FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y wget git pkg-config libfreetype6-dev
RUN /opt/conda/bin/conda install matplotlib==2.1.2
RUN conda install pandas
RUN conda install -c conda-forge jupyterlab
RUN conda install nodejs
RUN jupyter labextension install jupyterlab_vim
RUN pip install pydicom
RUN python -m pip install git+git://github.com/pydicom/pynetdicom3.git
RUN mkdir /code
ADD . /code
WORKDIR /code
RUN python /code/setup.py install
RUN /opt/conda/bin/jupyter-lab --generate-config
RUN cp /code/jupyter_notebook_config.py /root/.jupyter/
EXPOSE 8889
ENTRYPOINT ["/opt/conda/bin/jupyter-lab", "--ip=0.0.0.0", "--port=8889", "--allow-root"]
#RUN chmod 0755 /opt/conda/bin/deid
#ENTRYPOINT ["/opt/conda/bin/deid"]
