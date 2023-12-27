#-------------------------------------------------------------------------------------------------------
#  User's Guide
#
#  Copy this .cshrc environment setting file to the working (design project) directory, e.g.
#  /home/johndoe/project1, /home/johndoe/project2, ...., etc.
#
#  On terminal, cd to the working directory and type "csh" (without the quotes) to change
#  bash shell to C shell (make sure you have csh installed on the system, if not, install
#  csh first,  e.g. on Ubuntu issue command "sudo apt-get install csh" without the quotes
#  at the bash shell prompt $ to install csh).
#
#  Next at the C shell prompt %, source the .cshrc file by typing the following:
#  source .cshrc
#
#  Now all the environment variables in .cshrc file have been loaded into the C shell
#  and commands can be issued at the C shell prompt % to launch various Cadence tools,
#  for instance, "virtuoso &" (without the quotes).  Some frequently used commands are
#  listed in this file together with corresponding environment settings.
#
#  You may finish the Cadence session at any time by closing the running Cadence tool.
#  To start up another Cadence session, just issue another Cadence command at the shell
#  prompt %, e.g. "innovus &" (without the quotes), etc. To exit the entire Cadence
#  environment, just exit C shell.  By exiting C shell, all loaded Cadence and Calibre
#  environment variables are terminated since all of these variables are loaded and
#  contained in the terminated C shell.  The benefit of sourcing .cshrc to a local shell
#  terminal instead of setting them in the $HOME/.cshrc is that all of the loaded Cadence &
#  Calibre environment variables don't globally affect system environment settings and
#  therefore you can run other programs on the system normally and won't disturb the
#  Cadence session or vice versa.
#
#  If you're setting up a multiuser server, create a client copy of this .cshrc file and make
#  necessary changes accordingly, e.g. point CDS_LIC_FILE to the server's license directory
#  as port@hostname.  Instruct users to download it to the working directory on the client
#  machine and source the client copy before starting up any Cadence tool.
#-------------------------------------------------------------------------------------------------------

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# For proper distributed processing execution using Cadence PVS software, it requires
# that the following is set as the first line in .cshrc.
# Note: the space between the ! and $?prompt is required!
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if ( ! $?prompt ) then
   exit
endif

##############################################################
# Cadence Design Systems
#
# Master IC CAD flow including schematic capture, simulation, layout, and verification.
##############################################################
setenv CADHOME /home/icdesign/cadence

# Requied for Cadence on Linux
setenv LANG C

# Set netlisting mode
setenv CDS_Netlisting_Mode Analog

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Specify a search order for .cdsenv
#
# Load .cdsenv in the working directory ($CWD)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv CDS_LOAD_ENV CSF

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# browser setup for Cadence Help
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv MOZILLA_HOME /usr/bin/firefox

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Cadence - IC
#
# IC Schematic Entry, Simulation, Layout, Verification (Diva)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv CDS ${CADHOME}/IC618ISR9_lnx86

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Some of these variables are used by various other tools, e.g. foundry's PDK.
# Set them to be safe
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv CDSDIR ${CDS}
setenv CDSHOME ${CDS}
setenv CADENCE_DIR ${CDS}
setenv CDS_INST_DIR ${CDS}
setenv CDS_ROOT ${CDS}
setenv CDSROOT ${CDS}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up either CDS_LIC_FILE or LM_LICENSE_FILE, but NOT both or it'll
# take long time to search license!!!
#
# Set variable CDS_LIC_ONLY to ignore LM_LICENSE_FILE if it exists.
#
# Use absolute PATH to license.dat file instead of port@hostname
#
# The license server is no longer needed once all features are set to uncounted or 0
# (unlimited use) for the FEATURE lines in license.dat.  The SERVER, VENDOR and
# USE_SERVER lines can be safely removed from license.dat file, i.e. license.dat here
# contains FEATURE lines only.  DO NOT START UP LICENSE SERVER DAEMON!!!
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv CDS_LIC_FILE ${CADHOME}/license/license.dat
setenv CDS_LIC_ONLY 1

# Support for 64-bit executables (this should be set for 64-bit hosts - IMPORTANT!!!)
setenv CDS_AUTO_64BIT ALL

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Master IC PATH
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv PATH ${PATH}:${CDSDIR}/tools/dfII/bin:${CDSDIR}/tools/plot/bin

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up OA (OpenAccess)
#
# It is STRONGLY recommended that you DO NOT change the OA installation that
# each tool uses because tools are tested with the version of OA shipped with that
# particular tool such as EDI142. However, if it is necessary to use a different
# version of OA, you can do so with one of the following approaches:
# 1) Use the Configure utility on InstallScape to specify a different OA installation.
# 2) Use the OA_HOME environment variable to override the default OA installation.
#
# DO NOT set up OA_HOME as recommended above!  Instead use the default OA
# installed within each Cadence tool, or use Configure utility on InstallScape to
# re-set OA back to the original default OA installation in each product such as EDI,
# EXT, etc. if they were ever changed.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Set up for Cadence unsupported systems such as Ubuntu Linux
# IC617 supports Ubuntu14.04 so this variable is no longer required
#setenv OA_UNSUPPORTED_PLAT linux_rhel50_gcc44x

# To run Virtuoso Schematic and Verilog Driven Mixed-Signal Flow,  the following
# environment variable must be set before starting Virtuoso.
setenv CDS_ENABLE_VMS 1

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Cadence Analog Simulators (MMSIM) - Spectre, SpectreRF, &
# RelXpert (Reliability Simulator)
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv MMSIMHOME ${CADHOME}/MMSIM151
#setenv PATH ${PATH}:${MMSIMHOME}/bin:${MMSIMHOME}/tools/relxpert/bin

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Cadence QRC Extraction, Advanced Analysis & Modeling (EXT)
#
# Note: QRC must appear in the PATH before Assura executables
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv QRC_HOME ${CADHOME}/EXT151
#setenv PATH ${PATH}:${QRC_HOME}/bin

# Enhance precision of QRC for DFM MOS extraction
#setenv QRC_MOS_LW_PRECISION Y

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Cadence Assura (ASSURA) - DRC. LVS, parasitic extraction
#
# These executables should be on the PATH after DFII executables
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv ASSURAHOME ${CADHOME}/ASSURA41
#setenv PATH ${PATH}:${ASSURAHOME}/tools/bin:${ASSURAHOME}/tools/assura/bin

# Setting this variable enables Assura to work with PVS licenses only without
# attempts to check-out Assura licenses first and thus speeds up execution.
#setenv ASSURA_USE_PVS_LICENSE 1

# Set up foundry DFM PATH for Assura - CRNxxG/CRNxxLP process for current project
#setenv TSMC_ASU_DFM_PATH /opt/PDKs/tsmc/CRNxxG/Assura/lvs_rcx/DFM
#setenv TSMC_ASU_DFM_PATH /opt/PDKs/tsmc/CRNxxLP/Assura/lvs_rcx/DFM

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Cadence Physical Verification System, MaskCompose, & QuickView (PVS)
#
# K2_VIEWER_HOME must be set before Quickview is invoked. LM_LICENSE_FILE
# is required to run any K2 product.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv K2_HOME ${CADHOME}/PVS151/tools/K2
#setenv K2_VIEWER_HOME ${K2_HOME}/Viewer
#setenv K2_MASKCOMPOSE_HOME ${K2_HOME}/MaskCompose
#setenv K2_MC_DATA $HOME/Projects
#setenv LM_LICENSE_FILE ${CDS_LIC_FILE}
#setenv PATH ${PATH}:${CADHOME}/PVS151/bin:${CADHOME}/PVS151/tools/bin:${K2_MASKCOMPOSE_HOME}/bin
#setenv XKEYSYMDB ${CDSDIR}/tools/plot/etc/XKeysymDB

# Commands on terminal to launch Quickview or MaskCompose
#k2_viewer &
#k2_mcs &

##############################################################
# Cadence Digital Flow - HDL Simulations, Synthesis, P&R
#
##############################################################
# Genus Synthesis Solution (GENUS) - Logic & Physical Synthesis
setenv PATH ${PATH}:${CADHOME}/GENUS191/tools/bin:${CADHOME}/GENUS191/share/bin:${CADHOME}/GENUS191/tools.lnx86/bin

# Command on terminal to launch Genus
# genus

# RTL Power Analysis (Joules)
#setenv PATH ${PATH}:${CADHOME}/JLS151/bin

# Command on terminal to start Joules
# joules &

# Innovus Implementation System (INNOVUS) - P&R
setenv PATH ${PATH}:${CADHOME}/INNOVUS201/bin

# Command on terminal to launch Innovus
# innovus &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Cadence C-to-Silicon Compiler (CTOS)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv PATH ${PATH}:${CADHOME}/CTOS142/bin

# Command on terminal to launch CTOS
#ctosgui &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Encounter Conformal (CONFRML) - Constraint Designer, Low Power Designer,
# & ECO Designer
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv PATH ${PATH}:${CADHOME}/CONFRML152/bin

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Command on terminal to launch Confirmal with license options:
# -xl/-gxl/-rcv/-eco/-ecogxl/-lp/-lpxl/-ccd/-ccdxl/-lpgxl/-verify;
#  default is set to -l if no option is given.
# example:  "lec -lp -verify -gui &" for Low Power license and Verify license
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# lec -lpgxl -verify -gui &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Silicon Signoff & Verification (SSV) - including Tempus Timing Signoff
# & Voltus IC Power Integrity
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv PATH ${PATH}:${CADHOME}/SSV152/tools/bin

# Command on terminal to launch tempus or voltus
# tempus &
# voltus &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Incisive Verification Platform - Digital HDL simulators
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv PATH ${PATH}:$CADHOME/INCISIVE152/bin:${CADHOME}/INCISIVE152/tools/bin:${CADHOME}/#INCISIVE152/tools/vtools/vfault/bin

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# For 3-step (ncvlog, ncelab, and ncsim) flow to run Virtuoso AMS Designer simulator,
# the following library path environment variable has to be set.
#
# For single-step (irun) running AMS simulator, LD_LIBRARY_PATH is not required.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#if ($?LD_LIBRARY_PATH) then
#  setenv LD_LIBRARY_PATH ${CADHOME}/INCISIVE151/tools/lib/64bit:${CADHOME}/INCISIVE151/tools/lib
#else
#  setenv LD_LIBRARY_PATH ${CADHOME}/INCISIVE151/tools/lib/64bit:${CADHOME}/INCISIVE151/tools/lib
#endif

# Enable noise analysis in AMS designer
setenv AMS_ENABLE_NOISE YES

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up Universal Verification Methodology (UVM) Environment Variables
#
# uvm_home defines the path to the UVM class library
# ml_uvm defines the path to the ml_uvm code
# ml_seq_dir defines the path to the SystemVerilog ml_uvm_seq package for using
# sequencer stubs
# The SystemVerilog package ml_uvm_seq is included in the Specman installation.
# To use it, you must add the following command-line options to your compilation flow,
# as additional command-line arguments to irun or ncvlog :
# irun ... ${ML_SEQ_DIR}/ml_uvm_seq.sv -incdir ${ML_SEQ_DIR}
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv uvm_home ${CADHOME}/INCISIVE152/tools/uvm
setenv ml_uvm ${CADHOME}/INCISIVE152/tools/uvm/uvm_lib/uvm_ml/sc/ml_uvm
setenv ml_seq_dir ${CADHOME}/INCISIVE152/specman/src

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up the HOME Environment Variable for Incisive Verification Kits
# Source the appropriate environment setup file
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv SOCV_KIT_HOME ${CADHOME}/INCISIVE152/kits/VerificationKit
##source $SOCV_KIT_HOME/env.csh

# Command on terminal to start up Incisive Verification Kits
# start_kit &

#***********************************************************************
# Command on terminal launch NClaunch
#***********************************************************************
# nclaunch &

# Command on terminal to start up Specman & SimVision
# specman -gui &

# Command on terminal to invoke Desktop Manager
# emanager -desktop &
# vmanager &

# Encounter Diagnostics & Test (ET)
#setenv PATH ${PATH}:${CADHOME}/ET151/bin

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Command on terminal to launch ET,  or with license options: -architect/-truetime/-diag
# commands eta, ett and ediag are equivalent to et -architect, et -truetime and et -diag
# which invokes Encounter Test Architect,  Encounter True_time Delay Test and
# Encounter Diagnostics, respectively.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# eta &
# ett &
# ediag &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Verification IP Product Catalog (VIPCAT)
#
# VIP products are configured using a GUI called PureView.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv CDN_VIP_ROOT ${CADHOME}/VIPCAT113
#setenv CADENCE_VIP_LIC_ORDER newrev:soc:portfolio:alacarte
#setenv ABVIP_ISNT_DIR ${CDN_VIP_ROOT}/tools/abvip
# In e , set SPECMAN_PATH to the location of the specific UVC directory
#setenv SPECMAN_PATH ${CDN_VIP_ROOT}/utils:${CDN_VIP_ROOT}/packages:${CDN_VIP_ROOT}/vips/enet/#vr_enet
#setenv DENALI ${CDN_VIP_ROOT}/tools/denali_64bit
#setenv PATH ${PATH}:${DENALI}/bin
# In SV, add the UVC by including the specific VIP SV directory in the irun command
#irun -incdir $CDN_VIP_ROOT/vips/enet/vr_enet/sv

# Command on terminal to launch PureView to configure VIP products.
# pureview &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Manufacturability and Variability Sign-Off (MVS) - Litho Analyzers,
# CMP Predictor
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv PATH ${PATH}:${CADHOME}/MVS152/tools/bin

# Commands on terminal to launch Litho Analyzers, CMP Predictor
#lpa &
#lea &
# need to figure out correct license keys in license.dat for CMP Predictor
# (current ones don't work)
#cmms -ccp &
#cmms -ccpo &

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Library Characterizer (Liberate)
#
# Include the integrated Spectre in PATH
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv ALTOSHOME ${CADHOME}/LIBERATE151
#setenv PATH ${PATH}:${ALTOSHOME}/bin
#setenv PATH ${PATH}:${ALTOSHOME}/tools.lnx86/spectre/bin
#setenv ALTOS_64 1

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up NCSU CDK
#
# This is optional for educational purpose; use foundry provided PDKs
# instead for production projects by including foundry PDKs in cds.lib
# in the working directory.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv CDK_DIR /opt/PDKs/ncsu-cdk-1.6.0.beta

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Mentor Graphics Calibre
#
# MGC_HOME environment variable has been deprecated in favor
# of CALIBRE_HOME. MGC_HOME here set to CALIBRE_HOME is used
# for Calibre RealTime.
#
# Use absolute PATH to license.dat instead of port@hostname
#
# .cdsinit in the working directory should be modified for Calibre to
# be integrated into Virtuoso menu bar.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv MGC_HOME /home/icdesign/Mentor
setenv CALIBRE_HOME ${MGC_HOME}/Calibre2018/aoi_cal_2018.1_27.18
setenv MGLS_LICENSE_FILE ${MGC_HOME}/license/license.dat
setenv PATH ${PATH}:${CALIBRE_HOME}/bin
setenv MGC_LIB_PATH ${CALIBRE_HOME}/lib

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Mentor Environment Checking
#
# CALIBRE_OS_MSG_LEVEL variable is deprecated with the Calibre 2013.1 release.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#***********************************************************************
# Enable Calibre RealTime with Cadence Virtuoso
#***********************************************************************
setenv MGC_CALIBRE_REALTIME_VIRTUOSO_ENABLED 1
setenv OA_PLUGIN_PATH ${CALIBRE_HOME}/shared/pkgs/icv/tools/queryskl
if ($?LD_LIBRARY_PATH) then
  setenv LD_LIBRARY_PATH ${CALIBRE_HOME}/shared/pkgs/icv/tools/calibre_client/lib/64:${LD_LIBRARY_PATH}
else
  setenv LD_LIBRARY_PATH ${CALIBRE_HOME}/shared/pkgs/icv/tools/calibre_client/lib/64
endif
setenv MGC_CALIBRE_REALTIME_VIRTUOSO_SAVE_MESSENGER_CELL 1

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# This variable enables Calibre Interactive to save all GUI settings including default
# values to a runset file for future re-run
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv MGC_CALIBRE_SAVE_ALL_RUNSET_VALUES 1

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up socket connection with Virtuoso schematic or layout viewer (using default ports
# 9199 for schematic and 9189 for layout) in the form of host:port
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv MGC_CALIBRE_SCHEMATIC_SERVER ThinkPad-T510:9199
#setenv MGC_CALIBRE_LAYOUT_SERVER ThinkPad-T510:9189

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set up foundry DFM PATH for Calibre - CRNxxG/CRNxxLP process for current project
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#setenv TSMC_CAL_DFM_PATH /opt/PDKs/tsmc/CRNxxG/Calibre/lvs/DFM
#setenv TSMC_CAL_DFM_PATH /opt/PDKs/tsmc/RNxxLP/Calibre/lvs/DFM

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# The license server is no longer needed once all features are set to uncounted or 0
# (unlimited use) for the FEATURE lines in license.dat. file.  The SERVER, VENDOR and
# USE_SERVER lines can be safely removed from license.dat file, i.e. license.dat here
# contains FEATURE lines only.  DO NOT START UP LICENSE SERVER DAEMON!!!
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
setenv TEMPUSHOME /home/icdesign/cadence/SSV211
setenv PATH {$PATH}:${TEMPUSHOME}:${TEMPUSHOME}/share/bin:${TEMPUSHOME}/tools.lnx86/bin
#***********************************************************************
# Set the name of the executable for displaying PDF documentation from Calibre Help
# menu. The default is acroread if it exists.  Make sure evince has been installed before
# setting up the following (on Ubuntu type command "sudo apt-get install evince")
#***********************************************************************
#setenv MGC_PDF_READER evince

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Command on terminal to launch Cadence Virtuoso tools
#
# Adding & runs the process in the background allowing to continue using
# the current terminal.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# virtuoso &

setenv CLS_ALLOW_LOOPBACK_HOSTNAME true
unsetenv XMODIFIERS

setenv PVSHOME /home/icdesign/cadence/PVS191
setenv PATH {$PATH}:${PVSHOME}/bin:${PVSHOME}/share/bin:${PVSHOME}/tools.lnx86/bin
 
setenv SPECTRE_HOME /home/icdesign/cadence/SPECTRE191ISR8_lnx86
setenv PATH {$PATH}:${SPECTRE_HOME}/bin:${SPECTRE_HOME}/share/bin:${SPECTRE_HOME}/tools.lnx86/bin
 
setenv CONFRML /home/icdesign/cadence/CONFRML201
setenv PATH {$PATH}:${CONFRML}/bin:${CONFRML}/share/bin:${CONFRML}/tools.lnx86/bin

setenv STRATUS /home/icdesign/cadence/STRATUS211
setenv PATH {$PATH}:${STRATUS}/bin:${STRATUS}/share/bin:${STRATUS}/tools.lnx86/bin

setenv XCELIUM /home/icdesign/cadence/XCELIUM2303
setenv PATH {$PATH}:${XCELIUM}/bin:${XCELIUM}/share/bin:${XCELIUM}/tools.lnx86/bin

setenv QUANTUS_ENABLE_EXTRACTION
setenv QUANTUSHOME /home/icdesign/cadence/QUANTUS
setenv PATH {$PATH}:${QUANTUSHOME}/bin:${QUANTUSHOME}/share/bin:${QUANTUSHOME}/tools.lnx86/bin

setenv MODUSHOME /home/icdesign/cadence/MODUS19.10.000
setenv PATH {$PATH}:${MODUSHOME}/lnx86/bin:${MODUSHOME}/share/bin:${MODUSHOME}/tools.lnx86/bin

setenv JASPER /home/icdesign/cadence/Jasper
setenv PATH {$PATH}:${JASPER}/bin:${JASPER}/share/bin:${JASPER}/tools.lnx86/bin

setenv TEMPUSHOME /home/icdesign/cadence/SSV201
setenv PATH {$PATH}:${TEMPUSHOME}/bin:${TEMPUSHOME}/share/bin:${TEMPUSHOME}/tools.lnx86/bin

# refer to the GoldenGate Installation Guide for details
setenv XPEDION /home/icdesign/GoldenGate/GoldenGate-2020-Update-1.0
setenv XPEDION_CADENCE_VERSION 618
setenv GOLDENGATE_LICENSE_FILE /home/icdesign/Flexnet/Lic.lic

# add the path to the Keysight (agileesofd) license file at the end of the
# next line

setenv ADS_LICENSE_FILE /home/icdesign/Flexnet/Lic.lic
setenv HPEESOF_DIR /home/icdesign/ADS/Install
setenv PATH ${PATH}:${HPEESOF_DIR}/bin

setenv ossSimUserHnlDir ${HPEESOF_DIR}/idf/ads_site/hnl
setenv ossSimUserSiDir ${HPEESOF_DIR}/idf/ads_site/si

#setenv HSPICE_HOME /home/icdesign/Synopsys/HSPICE/Install/hspice
#setenv PATH {$PATH}:${HSPICE_HOME}/bin

#setenv SCL_HOME /home/icdesign/Synopsys/HSPICE/Install2/linux
#setenv PATH {$PATH}:${SCL_HOME}/bin

#setenv SNPSLMD_LICENSE_FILE 27010@this_host


