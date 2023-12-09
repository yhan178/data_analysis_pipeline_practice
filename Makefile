# Makefile
# Yi Han, 5 Dec 2023

# This driver script completes the textual analysis of
# four novels and creates figures on the 10 most frequently
# occuring words from each of the four novels. This script
# takes no arguments.

# example usage:
# run all analysis and create all figures: 
# make all
# run part of the analysis and create a certain figure: 
# make results/figure/isles.png

all: report/_build/html/index.html


# count the words
results/isles.dat : data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat
results/abyss.dat : data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat
results/last.dat : data/last.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat
results/sierra.dat : data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat

# create the plots
results/figure/isles.png : results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png
results/figure/abyss.png : results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png
results/figure/last.png : results/last.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png
results/figure/sierra.png : results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png


report/_build/html/index.html : report/count_report.ipynb \
	report/_toc.yml \
	report/_config.yml \
	results/figure/isles.png \
	results/figure/abyss.png \
	results/figure/last.png \
	results/figure/sierra.png
		jupyter-book build report

clean : 
	rm -rf results/isles.dat results/abyss.dat results/last.dat results/sierra.dat
	rm -rf results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	rm -rf report/_build