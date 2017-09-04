import os

c.NotebookApp.notebook_dir = '/home/jovyan/work'
c.NotebookApp.token = os.environ.get('NOTEBOOK_TOKEN', 'data-science')

