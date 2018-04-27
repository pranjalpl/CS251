all:app runtest analysis plot report

app:prog.o thread_function.o
	gcc prog.o thread_function.o -o app -lm -lpthread
prog.o:prog.c common.h
	gcc -c prog.c -I.
thread_function.o:thread_function.c common.h
	gcc -c thread_function.c -I. 
runtest:data.sh params.txt threads.txt app 
	./data.sh
analysis:analysis.sh format.sh speedup.sh data.txt avg.txt
	./analysis.sh
	./speedup.sh
	./format.sh
plot:scatter.p lineplot.p avg.txt data.txt error.txt speedup.txt avg2.txt speedup.p errorplot.p
	gnuplot scatter.p
	gnuplot lineplot.p
	gnuplot speedup.p
	gnuplot errorplot.p
report:report.tex scatter.p lineplot.p speedup.p errorplot.p
	pdflatex report.tex

clean:
	rm -f *.o app
	rm -f *.eps plot
	rm -f data.txt avg.txt avg2.txt runtest
	rm -f report.pdf report
	rm -f error.txt speedup.txt analysis
