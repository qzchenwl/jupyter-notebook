FROM jupyter/datascience-notebook

MAINTAINER qzchenwl <qzchenwl@gmail.com>

USER root

# Install pytalos

ADD patch.diff /tmp/
RUN pip install --pre pytalos -i http://pypi.sankuai.com/simple --trusted-host pypi.sankuai.com
RUN cd /opt/conda/lib/python3.6/site-packages/pytalos && \
    2to3 -w . && \
    patch < /tmp/patch.diff

# Install system dependencies

RUN apt-get update && apt-get install -y stow


# Install custom packages

USER $NB_USER

# Install packages

RUN pip install openpyxl bokeh plotly cufflinks

# JupyterLab

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install @jupyterlab/plotly-extension
RUN jupyter labextension install @jupyterlab/json-extension
RUN jupyter labextension install @jupyterlab/geojson-extension
RUN jupyter labextension install jupyterlab_bokeh

# Build and Install talos widget

RUN pip install ipytalos
RUN jupyter nbextension enable --py --sys-prefix ipytalos
RUN jupyter labextension install jupyterlab-talos

#RUN git clone  https://github.com/qzchenwl/ipytalos $HOME/.local/share/ipytalos && \
#    cd $HOME/.local/share/ipytalos && \
#    git checkout 7549f34 && \
#    python setup.py build && \
#    pip install -e . && \
#    jupyter nbextension install --py --symlink --sys-prefix ipytalos && \
#    jupyter nbextension enable --py --sys-prefix ipytalos && \
#    jupyter labextension install ./jslab

# Custom jupyter and ipython config

RUN ipython profile create
RUN jupyter notebook --generate-config
RUN rm -fv $HOME/.jupyter/jupyter_notebook_config.py

ADD dotfiles $HOME/dotfiles
RUN cd $HOME/dotfiles && stow -v jupyter

