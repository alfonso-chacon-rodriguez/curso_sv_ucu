# User specific environment and startup programs
# SystemVerilog course. UCU 2023
# Author: Alfonso Chacon-Rodriguez
## Last modification May/30/2023  
## QuestaSim version 
############# MGC Home ##################################
MGC_HOME=/var/mentor/amsv/amsv
export MGC_HOME
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/bin/X11:/usr/bin:/usr/local/bin:$MGC_HOME/bin
export LD_LIBRARY_PATH
PATH=$PATH:$MGC_HOME/bin
export PATH

############################################################################
####                 AMS (Eldo, ADMS) Variables setup    #####
#MGC_AMS_HOME=/mnt/vol_NFS_Zener/tools/mentor/apps/ams/ams_16_1
MGC_AMS_HOME=/var/mentor/amsv/amsv

export MGC_AMS_HOME
PATH=$MGC_AMS_HOME/bin:$HOME/bin:$PATH

###             Questa Sim setup              ########################

MODELTECH=$MGC_AMS_HOME/modeltech
export MODELTECH
PATH=$MODELTECH/bin:$PATH #PATH para QuestaSim, HDL Simul.

#####################################################################
#### GCC Compiler definition #####
COMPLETE_GCC_PATH=$MODELTECH/gcc-7.4.0-linux_x86_64/bin
export COMPLETE_GCC_PATH
PATH=$COMPLETE_GCC_PATH:$PATH

#####################################################################
####            Mentor Personal User Variables                   ####
#MGC_WD=/tmp
MGC_WD=~/curso_sv
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MGC_HOME/lib:$MGC_HOME/shared/lib
export MGC_WD

MGC_TMPDIR=$HOME/temp
export MGC_TMPDIR


