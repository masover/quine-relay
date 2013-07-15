MAKEFLAGS += --no-print-directory

all: QR2.rb
	diff QR.rb QR2.rb

QR.scala: QR.rb
	ruby QR.rb > QR.scala

QR.scm: QR.scala
	scalac QR.scala
	scala QR > QR.scm

QR.bash: QR.scm
	gosh QR.scm > QR.bash

QR.st: QR.bash
	bash QR.bash > QR.st

QR.tcl: QR.st
	gst QR.st > QR.tcl

QR.unl: QR.tcl
	tclsh QR.tcl > QR.unl

QR.vala: QR.unl
	ruby unlambda.rb QR.unl > QR.vala

QR.v: QR.vala
	valac QR.vala
	./QR > QR.v

QR.ws: QR.v
	iverilog -o QR QR.v
	./QR -vcd-none > QR.ws

QR.adb: QR.ws
	ruby whitespace.rb QR.ws > QR.adb

QR.a68: QR.adb
	gnatmake QR.adb
	./QR > QR.a68

QR.awk: QR.a68
	a68g QR.a68 > QR.awk

QR.boo: QR.awk
	awk -f QR.awk > QR.boo

QR.bf: QR.boo
	booi QR.boo > QR.bf

QR.c: QR.bf
	beef QR.bf > QR.c

QR.cpp: QR.c
	gcc -o QR QR.c
	./QR > QR.cpp

QR.cs: QR.cpp
	g++ -o QR QR.cpp
	./QR > QR.cs

QR.clj: QR.cs
	mcs QR.cs
	mono QR.exe > QR.clj

QR.cob: QR.clj
	clojure QR.clj > QR.cob

QR.coffee: QR.cob
	cobc -x QR.cob
	./QR > QR.coffee

QR.lisp: QR.coffee
	coffee QR.coffee > QR.lisp

QR.fs: QR.lisp
	clisp QR.lisp > QR.fs

QR.f: QR.fs
	gforth QR.fs > QR.f

QR.f90: QR.f
	gfortran -o QR QR.f
	./QR > QR.f90

QR.go: QR.f90
	gfortran -o QR QR.f90
	./QR > QR.go

QR.groovy: QR.go
	go run QR.go > QR.groovy

QR.hs: QR.groovy
	groovy QR.groovy > QR.hs

QR.icn: QR.hs
	runghc QR.hs > QR.icn

QR.i: QR.icn
	icont -s QR.icn
	./QR > QR.i

QR.j: QR.i
	mv QR.c QR.c.bak
	ick -b QR.i
	mv QR.c.bak QR.c
	./QR > QR.j

QR.java: QR.j
	jasmin QR.j
	java QR > QR.java

QR.ll: QR.java
	javac QR.java
	java QR > QR.ll

QR.logo: QR.ll
	llvm-as QR.ll
	lli QR.bc > QR.logo

QR.lua: QR.logo
	ucblogo QR.logo > QR.lua

QR.makefile: QR.lua
	lua QR.lua > QR.makefile

QR.il: QR.makefile
	make -f QR.makefile > QR.il

QR.js: QR.il
	ilasm QR.il
	mono QR.exe > QR.js

QR.m: QR.js
	nodejs QR.js > QR.m

QR.ml: QR.m
	gcc -o QR QR.m
	./QR > QR.ml

QR.octave: QR.ml
	ocaml QR.ml > QR.octave

QR.pasm: QR.octave
	octave -qf QR.octave > QR.pasm

QR.pas: QR.pasm
	parrot QR.pasm > QR.pas

QR.pl: QR.pas
	fpc QR.pas
	./QR > QR.pl

QR.php: QR.pl
	perl QR.pl > QR.php

QR.pike: QR.php
	php QR.php > QR.pike

QR.prolog: QR.pike
	pike QR.pike > QR.prolog

QR.py: QR.prolog
	swipl -q -t qr -f QR.prolog > QR.py

QR.R: QR.py
	python QR.py > QR.R

QR.rexx: QR.R
	R --slave < QR.R > QR.rexx

QR2.rb: QR.rexx
	rexx ./QR.rexx > QR2.rb
