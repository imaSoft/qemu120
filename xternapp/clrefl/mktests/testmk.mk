
# mkf.mk  for src/subdir

SRCS := test_main.cpp module_gen.cpp

export TOPROOT := $(CURDIR)/..
export SRCDIR := mktests

.phony: all pregen clean

all: pregen allsub allsubexe

clean: cleansub
	-rm log* module*

module_gen.cpp: pregen

include $(TOPROOT)/mkfinc.mk

pregen:
	../mkobj-dir/bin/clReflectScan test.cpp -i "../inc" \
		-output logcsv.csv -ast_log logast.txt -spec_log logspec.txt
	../mkobj-dir/bin/clReflectMerge module.csv \
		-cpp_codegen module_gen.cpp logcsv.csv 
	../mkobj-dir/bin/clReflectExport module.csv \
		-cpp     module_export.cppbin       \
		-cpp_log module_export_log.txt 

