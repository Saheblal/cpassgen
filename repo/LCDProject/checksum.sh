#!/bin/sh

hexmate -CK=0003-1FFF@2000w2 dist/default/production/MASZAT-II.production.hex -LOGFILE=output.log -OMASZATCRC.HEX -ADDRESSING=2 -FILL=0000@0003-1FFF
#hexmate -LOGFILE=output.log
