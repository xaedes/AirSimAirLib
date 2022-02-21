#!/bin/bash

ROOT_DIR=`realpath .`
echo ${ROOT_DIR}

AIRSIM_URL=https://github.com/microsoft/AirSim.git
TARGET_PROJECT_NAME=AirSimAirLib

ORIGINAL_INCLUDE_DIR=./AirSim/AirLib/include
ORIGINAL_SRC_DIR=./AirSim/AirLib/src

TARGET_INCLUDE_DIR=./${TARGET_PROJECT_NAME}/include/${TARGET_PROJECT_NAME}
TARGET_SRC_DIR=./${TARGET_PROJECT_NAME}/src

echo removing existing autogenerated AirLibAirSim code
rm -rf ${TARGET_INCLUDE_DIR}
rm -rf ${TARGET_SRC_DIR}

echo Download AirSim source code from ${AIRSIM_URL}
git clone ${AIRSIM_URL}

echo Creating target directory for includes
mkdir -p ${TARGET_INCLUDE_DIR}

echo Copying header files to new paths
cp -r ${ORIGINAL_INCLUDE_DIR}/* ${TARGET_INCLUDE_DIR}/

echo Copying source files to new paths
cp -r ${ORIGINAL_SRC_DIR} ${TARGET_SRC_DIR}

echo List all original header files
pushd ${ORIGINAL_INCLUDE_DIR}/ > /dev/null
find . -iname '*.hpp' > ${ROOT_DIR}/header_files.txt
popd  > /dev/null

# remove "./" at begin of each line
sed -i "s@^\./@@" header_files.txt

echo Make list of moved header files
sed "s@^@${TARGET_PROJECT_NAME}/@" header_files.txt > new_header_files.txt

echo List all files in which header paths will be replaced
find ${TARGET_INCLUDE_DIR} -iname '*.hpp' -type f > replace_in_files.txt
find ${TARGET_SRC_DIR} -iname '*.cpp' -type f >> replace_in_files.txt

echo Replace original header paths by moved header paths
python replace_strings.py header_files.txt new_header_files.txt replace_in_files.txt

echo Remove downloaded AirSim
rm -rf AirSim

echo Remove temporary files
rm header_files.txt
rm new_header_files.txt
rm replace_in_files.txt
