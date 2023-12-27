#!/usr/bin/bash

imc -execcmd "merge -runfile cov_paths.list -out cov_merged_data -overwrite"
imc -gui -load cov_work/scope/cov_merged_data &