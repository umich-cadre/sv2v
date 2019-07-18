#!/bin/bash

if [ $# -lt 4 ]
  then
  echo "Usage: snps_sv2v.sh {top-level-name} {include-path} {output-elab-file} {output-convert-file} {file1.sv file2.sv ...}"
  echo "Example: snps_sv2v.sh dff src/include dff.elab.v dff.out.v dff.sv"
  exit 1
fi

TOP_DESIGN=$1
INCLUDE_PATH=$2
OUTPUT_ELAB_FILE_NAME=$3
OUTPUT_CONV_FILE_NAME=$4

for var in "${@:5}"
  do
  VERILOG_FILES="$var $VERILOG_FILES"
done

echo "Top Level Design: $TOP_DESIGN"
echo "Verilog Include path: $INCLUDE_PATH"
echo "Output Elaborated File: $OUTPUT_ELAB_FILE_NAME"
echo "Output Converted File: $OUTPUT_CONV_FILE_NAME"
echo "System Verilog Files: $VERILOG_FILES"

dc_shell-t -x "
  set hdlin_infer_mux none; \
  set_app_var search_path {. $INCLUDE_PATH} ; \
  if { [analyze -format sverilog {$VERILOG_FILES}] == \"\" } { exit 1 } ; \
  elaborate $TOP_DESIGN ; \
  write -format verilog -hierarchy -output $OUTPUT_ELAB_FILE_NAME [get_object_name [get_designs]]; \
  exit
"

if [ $? -eq 0 ]
then
    echo "Elaboration completed successfully"
else
    echo "Elaboration failed"
    exit 1
fi

sed 's/\bGTECH_/UMICH_/' $OUTPUT_ELAB_FILE_NAME > $OUTPUT_CONV_FILE_NAME
sed -i 's/\bSELECT_OP\b/UMICH_SELECT_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bMUX_OP\b/UMICH_MUX_OP/' $OUTPUT_CONV_FILE_NAME

sed -i 's/\bLT_UNS_OP\b/UMICH_LT_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bLT_TC_OP\b/UMICH_LT_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bLEQ_UNS_OP\b/UMICH_LEQ_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bLEQ_TC_OP\b/UMICH_LEQ_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bGT_UNS_OP\b/UMICH_GT_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bGT_TC_OP\b/UMICH_GT_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bGEQ_UNS_OP\b/UMICH_GEQ_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bGEQ_TC_OP\b/UMICH_GEQ_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bEQ_UNS_OP\b/UMICH_EQ_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bEQ_TC_OP\b/UMICH_EQ_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bNE_UNS_OP\b/UMICH_NE_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bNE_TC_OP\b/UMICH_NE_TC_OP/' $OUTPUT_CONV_FILE_NAME

sed -i 's/\bADD_UNS_OP\b/UMICH_ADD_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bADD_TC_OP\b/UMICH_ADD_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bSUB_UNS_OP\b/UMICH_SUB_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bSUB_TC_OP\b/UMICH_SUB_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bMULT_UNS_OP\b/UMICH_MULT_UNS_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bMULT_TC_OP\b/UMICH_MULT_TC_OP/' $OUTPUT_CONV_FILE_NAME
sed -i 's/\bASH_UNS_UNS_OP\b/UMICH_ASH_UNS_UNS_OP/' $OUTPUT_CONV_FILE_NAME

sed -i 's/\\\*\*SEQGEN\*\* /UMICH_SEQGEN/' $OUTPUT_CONV_FILE_NAME

# grep "synch_preset(1'b1)" $OUTPUT_CONV_FILE_NAME
# grep "synch_toggle(1'b1)" $OUTPUT_CONV_FILE_NAME
# grep "synch_clear(1'b1)" $OUTPUT_CONV_FILE_NAME
# grep -E "synch_preset\([[:alpha:]]+\)" $OUTPUT_CONV_FILE_NAME
# grep -E "synch_toggle\([[:alpha:]]+\)" $OUTPUT_CONV_FILE_NAME
# grep -E "synch_clear\([[:alpha:]]+\)" $OUTPUT_CONV_FILE_NAME

