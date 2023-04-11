#you can download the clang-r383902b1 in this link: https://android.googlesource.com/platform//prebuilts/clang/host/linux-x86/+archive/4c6fbc28d3b078a5308894fc175f962bb26a5718/clang-r383902b1.tar.gz
PATH=$PATH:~/clang-r383902b1/bin

# User details
KBUILD_USER="$USER"
KBUILD_HOST=$(uname -n)
#
DEVICENAME='Motorola Edge s30'
CODENAME='xpeng'
SUFFIX='qgki'

CC='clang'
C_PATH="$TLDR/$CC"
CROSS_COMPILE="aarch64-linux-gnu-"
LLVM_PATH="$C_PATH/bin"

muke()
{
#	if [[ -z $COMPILER || -z $COMPILER32 ]]; then
#		error "Compiler is missing"
#	fi
	make "$@" "${MAKE_ARGS[@]}"
}

MAKE_ARGS+=("O=work" "ARCH=arm64"
	"CROSS_COMPILE=$CROSS_COMPILE"
	"TARGET_PRODUCT=dubai_g"
	"DTC_FLAGS+=-q" "DTC_EXT=$(which dtc)"
	"LLVM_IAS=1" "LLVM=1" "CC=$CC"
	"HOSTLD=ld.lld"	"PATH=$C_PATH/bin:$PATH"
	"KBUILD_BUILD_USER=$KBUILD_USER" "KBUILD_BUILD_HOST=$KBUILD_HOST"
	"$(head -1 build.config.common)" "$(head -2 build.config.common | tail -1)")

DFCF="vendor/${CODENAME}-${SUFFIX}_defconfig"

#export "${MAKE_ARGS[@]}" "TARGET_BUILD_VARIANT=user" "TARGET_PRODUCT=dubai_g"
#bash scripts/gki/generate_defconfig.sh "${CODENAME}-${SUFFIX}_defconfig"
#bash scripts/gki/generate_defconfig.sh "lahaina-qgki_defconfig"
#rm -rf arch/arm64/configs/vendor/lahaina-qgki_defconfig
#muke vendor/lahaina-qgki_defconfig vendor/"${CODENAME}"-"${SUFFIX}"_defconfig savedefconfig
#muke "$DFCF" vendor/lahaina_QGKI.config vendor/debugfs.config vendor/ext_config/moto-lahaina.config vendor/ext_config/moto-lahaina-dubai.config vendor/ext_config/debug-lahaina-dubai.config savedefconfig
#cat work/defconfig >arch/arm64/configs/"$DFCF"

#muke "$DFCF" savedefconfig
muke "$DFCF"
muke -j"$(nproc)"




