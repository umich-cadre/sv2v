export TEST_DIR = ./tests

# Get all test files (ends in .orig.v)
TEST_FILES = $(wildcard $(TEST_DIR)/*.orig.v)
TEST_NAMES = $(patsubst %.orig.v,%,$(notdir $(TEST_FILES)))

# Wildcarded Targets to built
CONV_TARGETS     := $(patsubst %.orig.v,%.conv.v,$(wildcard $(TEST_DIR)/*.orig.v))
ELAB_TARGETS     := $(patsubst %.orig.v,%.elab.v,$(wildcard $(TEST_DIR)/*.orig.v))
SIM_ORIG_TARGETS := $(patsubst %.orig.v,%.sim.orig,$(wildcard $(TEST_DIR)/*.orig.v))
SIM_CONV_TARGETS := $(patsubst %.orig.v,%.sim.conv,$(wildcard $(TEST_DIR)/*.orig.v))

# Default build target
all: $(SIM_ORIG_TARGETS) $(SIM_CONV_TARGETS)

# This target recipe performs simulation on the original test
$(SIM_ORIG_TARGETS): %.sim.orig : %.orig.v %.tb.v
	echo $(@:%.sim.orig=%.orig.v) $(@:%.sim.orig=%.tb.v)
	mkdir -p $@ && cd $@ && \
	vcs -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' \
	$(abspath $(@:%.sim.orig=%.orig.v)) \
	$(abspath $(@:%.sim.orig=%.tb.v)) \
	&& ./simv | tee output.txt

# This target recipe converts the original test to an elaborated and converted version
$(CONV_TARGETS): %.conv.v : %.orig.v
	./sv2v.sh \
	  $(patsubst %.conv.v,%,$(notdir $@)) \
	  $(@:%.conv.v=%.elab.v) \
	  $@ \
	  $(@:%.conv.v=%.orig.v)

# This target recipe performs simulation on the converted test using the umich_lib
$(SIM_CONV_TARGETS): %.sim.conv : %.conv.v %.tb.v umich_lib.v
	echo $(@:%.sim.conv=%.conv.v)
	mkdir -p $@ && cd $@ && \
	vcs -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' \
	$(abspath ./umich_lib.v) \
	$(abspath $(@:%.sim.conv=%.conv.v)) \
	$(abspath $(@:%.sim.conv=%.tb.v)) \
	&& ./simv | tee output.txt

test: $(foreach test,$(TEST_NAMES),test-$(test))

$(foreach test,$(TEST_NAMES),test-$(test)): test-% : $(TEST_DIR)/%.sim.orig $(TEST_DIR)/%.sim.conv
	# diff -I '^[^@].*' $(TEST_DIR)/$*.sim.orig/output.txt $(TEST_DIR)/$*.sim.conv/output.txt
	@if ! diff -I '^[^@].*' $(TEST_DIR)/$*.sim.orig/output.txt $(TEST_DIR)/$*.sim.conv/output.txt ; then echo -e "\033[0;31m$* test FAILED - stdout/$* \033[0m"; fi

# Clean
clean:
	rm -rf $(CONV_TARGETS)
	rm -rf $(ELAB_TARGETS)
	rm -rf $(SIM_ORIG_TARGETS)
	rm -rf $(SIM_CONV_TARGETS)

