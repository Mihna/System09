#-----------------------------------------------------------------
# File:    Makefile
# Author:  David Burnette
# Date:    April 7, 2008
#
# Description:
#  This makefile generates the S19 record file .S19 from the
#  assembler source.
#
#  This particular makefile handles generating the FLEX bootstrap loader
#
# Usage:
#  The targets generated by this makefile are:
#
#    make                     - makes all
#    make all                 - makes all
#    make bootcf8.S19         - CompactFlash bootstrap loader
#
# Target Descriptions:
#  The first file listed is the source file passed to assembler.
#  Remaining files are the dependencies. 
#
# Dependencies:
#  This makefile depends on def_rules.mk.
#
# Revision History:
#   dgb 2008-04-07   Original version
#
#-----------------------------------------------------------------

ifeq "$(MKFRAGS)" ""
MKFRAGS := ../../mkfiles
endif

include $(MKFRAGS)/def_rules.mk

all: bootcf8.S19

bootcf8.S19: bootcf8.asm

.PHONY: clean
clean:
	-$(RM) *.S19
	-$(RM) *.lst
