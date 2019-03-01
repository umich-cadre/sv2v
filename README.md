
# sv2v - System Verilog to Verilog
sv2v is a script that converts System Verilog code to Verilog code using commercial tools. The cdn_sv2v.sh script uses Cadence Genus while the snps_sv2v.sh script uses Synopsys Design Compiler. The commercial tools are used to elaborate the design and print out the intermediate/generic verilog before synthesis.

##Usage:
**Genus**

    cdn_sv2v.sh {top-level-name} {include-path} {output-elab-file} {output-convert-file} {file1.sv file2.sv ...}

**Design Compiler**
Note: you will need to include umich_snps_lib.v which contains the behavioral descriptions of the low level primitives used by design compiler.

    snps_sv2v.sh {top-level-name} {include-path} {output-elab-file} {output-convert-file} {file1.sv file2.sv ...}

`top-level-name` - This is the toplevel design that will be elaborated
`include-path` - A directory that will be added to paths searched for 'include files
`output-elab-file` - Output file for the elaborated Verilog untouched after running through the commercial tool
`output-convert-file` - Final output file after any necessary replacements
`file1.sv...` - Input System Verilog (or Verilog) files.


## Contributing
There are several tests in the `tests` folder, each test contains two files:
1. `{test_name}.orig.v` is the original code to be converted.
2. `{test_name}.tb.v` is the testbench that will run on the original code and the converted code.
(The picorv32 test is a 32 bit processor from an open source)


To run an individual test:
```Makefile
make test-{test_name}
```
To run all the tests:
```Makefile
make test
```
For each test run, the outputs from the testbench (running on the original and converted) be printed out.

To remove all the generated results, run:
```Makefile
make clean
```

