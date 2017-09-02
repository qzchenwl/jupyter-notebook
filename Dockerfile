FROM jupyter/all-spark-notebook

MAINTAINER qzchenwl <qzchenwl@gmail.com>

USER $NB_USER

ADD patch.diff /tmp/
RUN pip install --pre pytalos -i http://pypi.sankuai.com/simple --trusted-host pypi.sankuai.com
RUN cd /opt/conda/lib/python3.6/site-packages/pytalos && 2to3 -w . && patch < /tmp/patch.diff
RUN echo -e "progress=true\nregistry=https://registry.npm.taobao.org/" > ~/.npmrc
RUN git clone https://github.com/qzchenwl/jupyter_widget_talos ~/.local/share/jupyter_widget_talos
RUN cd ~/.local/share/jupyter_widget_talos && python setup.py build && pip install -e . && jupyter nbextension install --py --symlink --sys-prefix jupyter_widget_talos && jupyter nbextension enable --py --sys-prefix jupyter_widget_talos
