from __future__ import print_function
from IPython.core.magic import (Magics, magics_class, line_magic,
                                cell_magic, line_cell_magic)

from jupyter_widget_talos import TalosWidget

# The class MUST call this class decorator at creation time
@magics_class
class TalosMagics(Magics):

    @cell_magic
    def talos(self, line, cell):
        "my cell magic"

        engine, dsn = line.split(' ')
        return TalosWidget(engine=engine, dsn=dsn, sql=cell)

# In order to actually use these magics, you must register them with a
# running IPython.  This code must be placed in a file that is loaded once
# IPython is up and running:
ip = get_ipython()
# You can register the class itself without instantiating it.  IPython will
# call the default constructor on it.
ip.register_magics(TalosMagics)

