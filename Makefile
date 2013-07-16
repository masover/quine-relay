MAKEFLAGS += --no-print-directory

all: QR2.rb
	diff QR.rb QR2.rb

QR.scala: QR.rb
	ruby QR.rb > QR.scala

QR.vala: QR.scala
	scalac QR.scala
	scala QR | gosh | bash | gst | tclsh | ruby unlambda.rb /dev/stdin > QR.vala

QRvala: QR.vala
	valac -o QRvala QR.vala

QRv: QRvala
	./QRvala | iverilog -o QRv /dev/stdin

QR.adb: QRv
	./QRv -vcd-none | ruby whitespace.rb /dev/stdin > QR.adb

QR.a68: QR.adb
	gnatmake QR.adb
	./QR > QR.a68

QRc: QR.a68
	a68g QR.a68 | awk -f /dev/stdin | booi - | beef /dev/stdin | gcc -pipe -o QRc -xc -

QRcpp: QRc
	./QRc | g++ -o QRcpp -xc++ -

QR.cs: QRcpp
	./QRcpp > QR.cs

QRcs.exe: QR.cs
	mcs -out:QRcs.exe QR.cs

QRcob: QRcs.exe
	mono QRcs.exe | clojure - | cobc -x -o QRcob /dev/stdin

# While the latest CoffeeScript can _evaluate_ from stdin,
# this one can't, so we compile to JS and evaluate that instead.
QRf: QRcob
	./QRcob | coffee -sc | node | clisp - | gforth /dev/stdin | gfortran -pipe -o QRf -xf77 -

QRf90: QRf
	./QRf | gfortran -pipe -o QRf90 -xf95 -

QR.go: QRf90
	./QRf90 > QR.go

QR.groovy: QR.go
	go run QR.go > QR.groovy

QR.hs: QR.groovy
	groovy QR.groovy > QR.hs

QRicn: QR.hs
	runghc QR.hs | icont -so QRicn -

QR.i: QRicn
	./QRicn > QR.i
   
QR.j: QR.i
	ick -b QR.i
	./QR > QR.j

QR.java: QR.j
	jasmin QR.j
	java QR > QR.java

QRil.exe: QR.java
	javac QR.java
	java QR | llvm-as | lli | ucblogo /dev/stdin | lua | make -f - | ilasm -out:QRil.exe /dev/stdin

QRm: QRil.exe
	mono QRil.exe | nodejs | gcc -pipe -o QRm -xobjective-c -

QR.pasm: QRm
	./QRm | ocaml /dev/stdin | octave -qf > QR.pasm

QR.pas: QR.pasm
	parrot QR.pasm > QR.pas

QRpas: QR.pas
	fpc -oQRpas QR.pas

QR.pike: QRpas
	./QRpas | perl | php > QR.pike

QR2.rb: QR.pike
	pike QR.pike | swipl -q -t qr -f /dev/stdin | python | R --slave | rexx > QR2.rb
