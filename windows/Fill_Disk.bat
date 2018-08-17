@echo off
rem ============================================================================
rem filldisk.bat
rem 
rem Fills the current disk drive with many large data files.
rem This has the effect of wiping out all the unallocated file blocks and all
rem the file blocks from previously deleted files (which may contain sensitive
rem personal information) on the current drive.
rem 
rem This is not a guaranteed way to completely wipe out all traces of your old
rem data files, but it's pretty good.
rem
rem usage: filldisk D
rem
rem The 'D' parameter specifies the disk drive to fill, and is required.
rem
rem Note that filling an active disk drive beyond 90% of its capacity will
rem probably cause MS/Windows to complain, especially if it is the Windows
rem system drive.
rem
rem This works on MS/DOS 2.0 or later.
rem
rem 1.0, 2003-01-17, David R. Tribble, <david@tribble.com>.
rem This code is not copyrighted and is in the public domain.
rem ============================================================================

rem ====================================
rem Run in a temporary directory on the specified (or current) drive

if not (%1) == () goto setdisk
echo Fill the current disk drive with many large data files.
echo.
echo usage: filldisk D
echo.
echo The 'D' parameter specifies the disk drive to fill, and is required.
goto end

:setdisk
set i=%1
shift
echo Changing to drive: %i%:
%i%:

if exist fstemp\. goto skipmd
echo Creating temporary subdirectory "fstemp"
mkdir fstemp
:skipmd

chdir fstemp

rem ====================================
rem Create a large file (128 MB) containing random data

echo.
echo Creating temporary data file: fs0.dat
echo Booger> fs0.tmp

echo Creating temporary data file: fs1.dat
set i=a
:loop1
copy /b fs0.tmp+fs0.tmp+fs0.tmp+fs0.tmp fs1.tmp >nul
copy /b fs1.tmp+fs1.tmp+fs1.tmp+fs1.tmp fs0.tmp >nul
set i=%i%b
if not (%i%) == (abbbbbb) goto loop1
:endloop1

rem ====================================
rem Copy the random data file to multiple files until the disk fills up

echo.
echo Filling the disk with random data files...
echo (This should eventually fail when the disk is almost full)
echo (If it does not fill the disk, run it again in a different directory)

rem These nested loops will create 10x10x10x10 = 10,000 files
rem This gives a total of 128MB x 10,000 = 1,280,000 MB = 1,250 GB

set i=0
:loop2i

set j=0
:loop2j

echo.
set k=0
:loop2k

set m=0
:loop2m

echo writing: fs%i%%j%%k%%m%.tmp
copy /b fs0.tmp fs%i%%j%%k%%m%.tmp >nul

if (%m%) == (9) goto endloop2m
if (%m%) == (8) set m=9
if (%m%) == (7) set m=8
if (%m%) == (6) set m=7
if (%m%) == (5) set m=6
if (%m%) == (4) set m=5
if (%m%) == (3) set m=4
if (%m%) == (2) set m=3
if (%m%) == (1) set m=2
if (%m%) == (0) set m=1
goto loop2m
:endloop2m

if (%k%) == (9) goto endloop2k
if (%k%) == (8) set k=9
if (%k%) == (7) set k=8
if (%k%) == (6) set k=7
if (%k%) == (5) set k=6
if (%k%) == (4) set k=5
if (%k%) == (3) set k=4
if (%k%) == (2) set k=3
if (%k%) == (1) set k=2
if (%k%) == (0) set k=1
goto loop2k
:endloop2k

if (%j%) == (9) goto endloop2j
if (%j%) == (8) set j=9
if (%j%) == (7) set j=8
if (%j%) == (6) set j=7
if (%j%) == (5) set j=6
if (%j%) == (4) set j=5
if (%j%) == (3) set j=4
if (%j%) == (2) set j=3
if (%j%) == (1) set j=2
if (%j%) == (0) set j=1
goto loop2j
:endloop2j

if (%i%) == (9) goto endloop2i
if (%i%) == (8) set i=9
if (%i%) == (7) set i=8
if (%i%) == (6) set i=7
if (%i%) == (5) set i=6
if (%i%) == (4) set i=5
if (%i%) == (3) set i=4
if (%i%) == (2) set i=3
if (%i%) == (1) set i=2
if (%i%) == (0) set i=1
goto loop2i
:endloop2i

:end