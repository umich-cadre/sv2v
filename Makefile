export TEST_DIR = ./tests
COMPARE_TOOL = bcompare
VCSFLAGS = -timescale=1ns/1ns +v2k +vc -Mupdate -line -full64 -sverilog -notice -debug_access+all +vcs+initreg+random
SIMVFLAGS = +vcs+initreg+0

# ## For Cadence
# CONV_TOOL = ./cdn_sv2v.sh
# CONV_LIB_V =

# For Synopsys
CONV_TOOL = ./snps_sv2v.sh
CONV_LIB_V = ./umich_snps_lib.v

# Get all test files (ends in .orig.v)
TEST_FILES = $(wildcard $(TEST_DIR)/*.orig.v)
TEST_NAMES = $(patsubst %.orig.v,%,$(notdir $(TEST_FILES)))

# Wildcarded Targets to built
CONV_TARGETS     := $(patsubst %.orig.v,%.conv.v,$(wildcard $(TEST_DIR)/*.orig.v))
ELAB_TARGETS     := $(patsubst %.orig.v,%.elab.v,$(wildcard $(TEST_DIR)/*.orig.v))
SIM_ORIG_TARGETS := $(patsubst %.orig.v,%.sim.orig,$(wildcard $(TEST_DIR)/*.orig.v))
SIM_CONV_TARGETS := $(patsubst %.orig.v,%.sim.conv,$(wildcard $(TEST_DIR)/*.orig.v))

# Default build target
all: test

# This target recipe performs simulation on the original test
$(SIM_ORIG_TARGETS): %.sim.orig : %.orig.v %.tb.v
	echo $(@:%.sim.orig=%.orig.v) $(@:%.sim.orig=%.tb.v)
	mkdir -p $@ && cd $@ && \
	vcs $(VCSFLAGS) \
	$(abspath $(@:%.sim.orig=%.orig.v)) \
	$(abspath $(@:%.sim.orig=%.tb.v)) \
	| tee build.txt \
	&& ./simv $(SIMVFLAGS) | tee output.txt

# This target recipe converts the original test to an elaborated and converted version
$(CONV_TARGETS): %.conv.v : %.orig.v
	$(CONV_TOOL) \
	  $(patsubst %.conv.v,%,$(notdir $@)) \
	  . \
	  $(@:%.conv.v=%.elab.v) \
	  $@ \
	  $(@:%.conv.v=%.orig.v)

# This target recipe performs simulation on the converted test using the umich_lib
$(SIM_CONV_TARGETS): %.sim.conv : %.conv.v %.tb.v $(CONV_LIB_V)
	echo $(@:%.sim.conv=%.conv.v)
	mkdir -p $@ && cd $@ && \
	vcs $(VCSFLAGS) \
	$(abspath $(CONV_LIB_V)) \
	$(abspath $(@:%.sim.conv=%.conv.v)) \
	$(abspath $(@:%.sim.conv=%.tb.v)) \
	| tee build.txt \
	&& ./simv $(SIMVFLAGS) | tee output.txt

test: $(foreach test,$(TEST_NAMES),test-$(test))

$(foreach test,$(TEST_NAMES),test-$(test)): test-% : $(TEST_DIR)/%.sim.orig $(TEST_DIR)/%.sim.conv
	@# diff -I '^[^@].*' $(TEST_DIR)/$*.sim.orig/output.txt $(TEST_DIR)/$*.sim.conv/output.txt
	@if ! diff -I '^[^@].*' $(TEST_DIR)/$*.sim.orig/output.txt $(TEST_DIR)/$*.sim.conv/output.txt > /dev/null ; then echo -e "\033[0;31m$* test FAILED - $* \033[0m"; fi

# Clean
clean:
	rm -rf $(CONV_TARGETS)
	rm -rf $(ELAB_TARGETS)
	rm -rf $(SIM_ORIG_TARGETS)
	rm -rf $(SIM_CONV_TARGETS)
	rm -rf genus.cmd*
	rm -rf genus.log*

$(foreach test,$(TEST_NAMES),clean-$(test)): clean-% :
	rm -f $(TEST_DIR)/$*.conv.v
	rm -f $(TEST_DIR)/$*.elab.v
	rm -rf $(TEST_DIR)/$*.sim.orig
	rm -rf $(TEST_DIR)/$*.sim.conv

$(foreach test,$(TEST_NAMES),diff-$(test)): diff-% :
	$(COMPARE_TOOL) $(TEST_DIR)/$*.sim.orig/output.txt $(TEST_DIR)/$*.sim.conv/output.txt

$(foreach test,$(TEST_NAMES),dve-conv-$(test)): dve-conv-% : $(TEST_DIR)/%.sim.conv
	$</simv $(SIMVFLAGS) -gui

$(foreach test,$(TEST_NAMES),dve-orig-$(test)): dve-orig-% : $(TEST_DIR)/%.sim.orig
	$</simv $(SIMVFLAGS) -gui
