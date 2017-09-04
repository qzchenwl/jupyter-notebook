FROM jupyter/all-spark-notebook

MAINTAINER qzchenwl <qzchenwl@gmail.com>

USER $NB_USER

ADD patch.diff /tmp/

# Install pytalos
RUN pip install --pre pytalos -i http://pypi.sankuai.com/simple --trusted-host pypi.sankuai.com
RUN cd /opt/conda/lib/python3.6/site-packages/pytalos && 2to3 -w . && patch < /tmp/patch.diff

# Build and Install talos widget
RUN git clone https://github.com/qzchenwl/jupyter_widget_talos $HOME/.local/share/jupyter_widget_talos

RUN cd $HOME/.local/share/jupyter_widget_talos && python setup.py build && pip install -e . && jupyter nbextension install --py --symlink --sys-prefix jupyter_widget_talos && jupyter nbextension enable --py --sys-prefix jupyter_widget_talos


# Custom jupyter and ipython config
RUN ipython profile create
RUN jupyter notebook --generate-config
RUN rm -fv $HOME/.jupyter/jupyter_notebook_config.py

ADD dotfiles $HOME/dotfiles

USER root
RUN apt-get update && apt-get install -y stow

USER $NB_USER
RUN cd $HOME/dotfiles && stow -v jupyter

