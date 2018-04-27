set terminal postscript eps enhanced color

set xlabel "Number of Elements"
set ylabel "Execution Time(in microseconds)"
set yrange[1:70000]
set xrange[1:1100000]
set logscale x 10
set key left top

set output "avg.eps"

plot 'avg2.txt' using 1:($2 == 1 ? $3 : 1/0) title "1 Thread" with lines, \
     '' using 1:($2 == 2 ? $3 : 1/0) title "2 Threads" with lines,\
     '' using 1:($2 == 4 ? $3 : 1/0) title "4 Threads" with lines,\
     '' using 1:($2 == 8 ? $3 : 1/0) title "8 Threads" with lines,\
     '' using 1:($2 == 16 ? $3 : 1/0) title "16 Threads" with lines 
