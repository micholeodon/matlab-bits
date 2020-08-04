disp 'Visualizing and saving ...'
close
h = figure
plot(t,y)
savefig(h, [CFG.output_data_f, 'fig/', 'yfig_', id])