#!/usr/bin/env bash

OriginDir=origin
SourceDir=origin
PatchesDir=patches
ExtrasDir=extras
TmpDir=tmp
OutDir=out

# check tools are available
PatchMatic=$(which patchmatic)
Iasl=$(which iasl)

if [ "x$PatchMatic" == "x" ] ; then
	if [ -f "./patchmatic" ] ; then
		PatchMatic=./patchmatic
	else 
		echo "patchmatic is not found in path, please place a copy here"
		exit 9
	fi
fi

if [ "x$Iasl" == "x" ] ; then
	if [ -f "./iasl" ] ; then
		Iasl=./iasl
	else
		echo "iasl is not found in path, please place a copy here"
		exit 9
	fi
fi

echo "=========================================================="
echo "Using patchmatic : $PatchMatic"
echo "Using iasl : $Iasl"
echo ""

# Create $TmpDir and $OutDir...
mkdir -p $TmpDir
mkdir -p $OutDir

# Look for sub-directories under $PatchesDir, each sub-directory name
# should correspond to a DSDT/SSDT to be patched
for ssdt in $(ls $PatchesDir); do
	echo "---------------------------------------------------------"
	echo "Applying patches for $ssdt ..."
	n=0
	cp $SourceDir/${ssdt}.dsl $TmpDir/${ssdt}_patch-${n}.dsl

	for patch in $(cd $PatchesDir/$ssdt; ls *.txt); do
		(( i = n ))
		(( n = n + 1 ))
		echo "    $n: $patch ..."
		$PatchMatic $TmpDir/${ssdt}_patch-${i}.dsl $PatchesDir/$ssdt/$patch $TmpDir/${ssdt}_patch-${n}.dsl
	done

	# applied all patches, copy the final dsl to $OutDir
	echo "---------------------------------------------------------"
	echo "Patching done, copying $ssdt to $OutDir/${ssdt}.dsl ..."
	cp $TmpDir/${ssdt}_patch-${n}.dsl $OutDir/${ssdt}.dsl

done

echo
echo "---------------------------------------------------------"
echo "Copying extra(custom) DSLs to $OutDir ..."
cp $ExtrasDir/*.dsl $OutDir/

# All patches applied, not compile
echo
echo "---------------------------------------------------------"
echo "Compiling DSLs in $OutDir ..."

( cd $OutDir ; $Iasl -ve *.dsl )


# Copy unmodified AMLs from Origin...
echo
echo "---------------------------------------------------------"
echo "Copying unmodified SSDTs to $OutDir ..."

for origin in $(cd $OriginDir; ls *.aml); do
	if [ -f $OutDir/$origin ] ; then
		echo "Patched $origin found, skipping ... "
	else
		echo "Copying $origin to $OutDir ..."
		cp $OriginDir/$origin $OutDir
	fi
done


echo; echo
echo "=========================================================="
echo "Done!"
echo "    - Verify results in $TmpDir and $OutDir before copying into EFI"
echo "    - Remember to update clover config.plist -> SSDT ordering"
echo
