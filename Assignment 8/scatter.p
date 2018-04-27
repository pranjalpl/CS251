set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xlabel "Number of Elements"
set ylabel "Execution Time(in microseconds)"
set yrange[1:70000]
set xrange[1:1500000]
set ytic auto
set xtic auto
set logscale x 10
unset logscale y


set output "scatter1.eps"
plot 'data.txt' using 1:($2 == 1 ? $3 : 1/0) title "1 thread" with points pt 2 ps 1 lc rgb "blue"
set output "scatter2.eps"
plot 'data.txt' using 1:($2 == 2 ? $3 : 1/0) title "2 threads" with points pt 2 ps 1 lc rgb "blue"
set output "scatter3.eps"
plot 'data.txt' using 1:($2 == 4 ? $3 : 1/0) title "4 threads" with points pt 2 ps 1 lc rgb "blue"
set output "scatter4.eps"
plot 'data.txt' using 1:($2 == 8 ? $3 : 1/0) title "8 threads" with points pt 2 ps 1 lc rgb "blue"
set output "scatter5.eps"
plot 'data.txt' using 1:($2 == 16 ? $3 : 1/0) title "16 threads" with points pt 2 ps 1 lc rgb "blue"
 
