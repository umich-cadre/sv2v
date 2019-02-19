read_verilog $::env(TEST_DIR)/$::env(TEST).v
write -format verilog -output $::env(TEST_DIR)/$::env(TEST).elab.v

exit
