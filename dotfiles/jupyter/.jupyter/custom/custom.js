require(['notebook/js/codecell'], function(codecell) {

  codecell.CodeCell.options_default.highlight_modes['magic_sql'] = {'reg':[/^%%talos/]} ;

  if (!Jupyter.notebook) {
    return;
  }

  Jupyter.notebook.events.one('kernel_ready.Kernel', function() {

    Jupyter.notebook.get_cells().map(function(cell) {
      if (cell.cell_type == 'code') {
        cell.auto_highlight();
      }
    });

  });

});
