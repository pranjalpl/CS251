set terminal postscript eps enhanced color size 3.9,2.9

set xlabel "Number of Elements"
set ylabel "Average Speedup"
set yrange[0:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
set key top left

set output "speedup.eps"
plot 'speedup.txt' u 2:xticlabels(1) title "1 Thread",\
'' u 3 title "2 Threads" fillstyle pattern 7,\
'' u 4 title "4 Threads" fillstyle pattern 12,\
'' u 5 title "8 Threads" fillstyle pattern 14,\
'' u 6 title "16 Threads" fillstyle pattern 16