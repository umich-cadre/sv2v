#!/bin/bash

if [ $# -lt 3 ]
  then
  echo "Usage: sv2v.sh {top-level-name} {output-elab-file} {output-convert-file} {file1.sv file2.sv ...}"
  echo "Example: sv2v.sh dff dff.out.v dff.sv"
  exit 1
fi

TOP_DESIGN=$1
OUTPUT_ELAB_FILE_NAME=$2
OUTPUT_CONV_FILE_NAME=$3

for var in "${@:4}"
  do
  VERILOG_FILES="$var $VERILOG_FILES"
done


echo "Top Level Design: $TOP_DESIGN"
echo "Output Elaborated File: $OUTPUT_ELAB_FILE_NAME"
echo "Output Converted File: $OUTPUT_CONV_FILE_NAME"
echo "System Verilog Files: $VERILOG_FILES"

dc_shell -x "
  if { [read_verilog $VERILOG_FILES] == \"\" } { exit 1 } ; \
  current_design $TOP_DESIGN ; \
  write -format verilog -hierarchy -output $OUTPUT_ELAB_FILE_NAME ; \
  exit
"

if [ $? -eq 0 ]
then
    echo "Elaboration completed successfully"
else
    echo "Elaboration failed"
    exit 1
fi

sed 's/GTECH_/UMICH_/' $OUTPUT_ELAB_FILE_NAME > $OUTPUT_CONV_FILE_NAME
sed -i 's/SELECT_OP/UMICH_SELECT_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/ADD_UNS_OP/UMICH_ADD_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/ADD_TC_OP/UMICH_ADD_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/ASH_UNS_UNS_OP/UMICH_ASH_UNS_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\\\*\*SEQGEN\*\* /UMICH_SEQGEN/' $OUTPUT_CONV_FILE_NAME

