all: clean run smoke 

FLIST="-f /home/icdesign/AHB-Lite-Semester-Project/flist.f"
BASICFLAGS="-access +rwc -disable_sem2009 -clean"
GUI="-gui"
DUT="/home/icdesign/AHB-Lite-Semester-Project/rtl/design.sv"
TOP="/home/icdesign/AHB-Lite-Semester-Project/sim/testbench.sv"
COVFLAGS="-covfile /home/icdesign/AHB-Lite-Semester-Project/cov/covfile.ccf -coverage all -covoverwrite"
FLAGS="${BASICFLAGS} ${COVFLAGS}"

.PHONNY: all

count = 1 2 3 4 5 6 7 8 9 10 11 12
test?=0

run: 
	@-cd ./test$(test); xrun ${FLIST} ${DUT} ${TOP} ${FLAGS} -define TEST$(test)

smoke: 
	@-$(foreach var,$(count), cd ./test$(var); xrun ${FLIST} ${DUT} ${TOP} ${FLAGS} -define TEST$(var); cd ../;)

gui: 
	@-cd ./test$(test); xrun ${FLIST} ${DUT} ${TOP} ${FLAGS} ${GUI} -define TEST$(test)

clean:
	@-rm -rf ./xcelium.d
	@-rm -rf ./*.shm
	@-rm -rf ./cov_work
	@-rm ./*.log
	@-rm ./*.history
	@-rm ./*.key
	@-rm ./*.vcd
	@-rm -rf ./.simvision
	@-$(foreach var,$(count), cd ./test$(var);  ./clean.sh ; cd ../;)
	@-clear
