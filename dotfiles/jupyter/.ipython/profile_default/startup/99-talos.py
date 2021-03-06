from __future__ import print_function
import time
from IPython.display import clear_output
from IPython.core.magic import (Magics, magics_class, line_magic,
                                cell_magic, line_cell_magic)

from ipytalos import Talos

# The class MUST call this class decorator at creation time
@magics_class
class TalosMagics(Magics):

    @cell_magic
    def talos(self, line, cell):
        "my cell magic"

        engine, dsn = line.split(' ')
        return Talos(engine=engine, dsn=dsn, sql=cell)

    @cell_magic
    def talos2(self, line, cell):
        "my cell magic"

        engine, dsn = line.split(' ')
        w = Talos(engine=engine, dsn=dsn, sql=cell)
        display(w)
        while w.update():
            time.sleep(1)
        clear_output()
        return w


# In order to actually use these magics, you must register them with a
# running IPython.  This code must be placed in a file that is loaded once
# IPython is up and running:
ip = get_ipython()
# You can register the class itself without instantiating it.  IPython will
# call the default constructor on it.
ip.register_magics(TalosMagics)

