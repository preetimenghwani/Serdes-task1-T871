
BOARD="MachXO2"
DEVICE="LCMXO2-1200HC"
PKG="TQFP100"
GRADE=4
SEARCH="/home/preeti/Downloads/usr/local/diamond/3.10_x64/ispfpga/vhdl/data/"

ALL:	deserializer.bit

%.edi : %.vhd 
	synpwrap -prj $*.prj

%.ngo : %.edi
	edif2ngd -l $(BOARD) -d $(DEVICE) $< $@

%.ngd : %.ngo
	ngdbuild -a $(BOARD) -d $(DEVICE) -p $(SEARCH) $< $@

%.ncd : %.ngd %.lpf
	map -a $(BOARD) -p $(DEVICE) -t $(PKG) -s $(GRADE) $< -o $@ $*.lpf

%.o.ncd : %.ncd
	par -w $< $*.o.ncd $*.prf

%.jed : %.o.ncd
	bitgen -w -jedec $< $@

%.bit : %.o.ncd
	bitgen -w $< $@

clean:
	rm -f *~
	rm -f *.alt *.areasrr *.asd
	rm -f *.bgn *.cam *.drc *.edi
	rm -f *.fse *.hrr *.mrp *.rbt
	rm -f *.ncd *.pad *.par *.prf
	rm -f *.prs *.rpt *.sdc *.srd
	rm -f *.srm *.srr *.srs *.twr
	rm -f *.log *.htm *.bak 
	rm -f *.jed *.hex *.bit *.mcs
	rm -f *_synplify.lpf
	rm -f *.svf{,.sram,.flash}
	rm -f run_options.txt
	rm -rf backup
	rm -rf dm
	rm -rf coreip
	rm -rf physical_plus
	rm -rf synlog
	rm -rf synwork
	rm -rf syntmp

