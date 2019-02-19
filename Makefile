export ROOT_DIR = $(abspath ./)
export TEST_DIR = $(abspath ./tests)

TEST = dFlipFlop
# TEST = dlatch

all: sim_clean elab sv2v sim_conv

sim_clean:
	mkdir -p $(TEST_DIR)/$(TEST)_sim_clean && \
	cd $(TEST_DIR)/$(TEST)_sim_clean && \
	vcs -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' \
	$(TEST_DIR)/$(TEST).v $(TEST_DIR)/$(TEST).tb.v  && ./simv | tee output.txt

	# $(TEST_DIR)/$(TEST).v $(TEST_DIR)/$(TEST).tb.v  -debug_access+r && ./simv

elab:
	export TEST=$(TEST) ; \
	dc_shell-t -f elab.tcl

sv2v:
	sed 's/GTECH_/UMICH_/' $(TEST_DIR)/$(TEST).elab.v > $(TEST_DIR)/$(TEST).conv.v
	sed -i 's/\\\*\*SEQGEN\*\* /UMICH_SEQGEN/' $(TEST_DIR)/$(TEST).conv.v

sim_conv:
	mkdir -p $(TEST_DIR)/$(TEST)_sim_conv && \
	cd $(TEST_DIR)/$(TEST)_sim_conv && \
	vcs -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-sverilog' \
	$(ROOT_DIR)/umich_lib.v $(TEST_DIR)/$(TEST).conv.v $(TEST_DIR)/$(TEST).tb.v  && ./simv | tee output.txt

clean:
	rm -rf $(TEST_DIR)/$(TEST)_sim_clean $(TEST_DIR)/$(TEST)_sim_conv
	rm -rf $(TEST_DIR)/$(TEST).elab.v $(TEST_DIR)/$(TEST).conv.v