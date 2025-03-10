#!/bin/bash
# Copyright (c) 2018-2021, NVIDIA CORPORATION.
#
# Adopted from https://github.com/tmcdonell/travis-scripts/blob/dfaac280ac2082cd6bcaba3217428347899f2975/update-accelerate-buildbot.sh

set -e

# Setup 'gpuci_retry' for upload retries (results in 4 total attempts)
export GPUCI_RETRY_MAX=3
export GPUCI_RETRY_SLEEP=30

# Set default label options if they are not defined elsewhere
export LABEL_OPTION=${LABEL_OPTION:-"--label main"}

# Skip uploads unless BUILD_MODE == "branch"
if [ ${BUILD_MODE} != "branch" ]; then
  echo "Skipping upload"
  return 0
fi

# Skip uploads if there is no upload key
if [ -z "$MY_UPLOAD_KEY" ]; then
  echo "No upload key"
  return 0
fi

################################################################################
# SETUP - Get conda file output locations
################################################################################

gpuci_logger "Get conda file output locations"

export LIBCUGRAPH_FILE=`conda build --no-build-id --croot ${CONDA_BLD_DIR} conda/recipes/libcugraph --output`
export LIBCUGRAPH_ETL_FILE=`conda build --no-build-id --croot ${CONDA_BLD_DIR} conda/recipes/libcugraph_etl --output`
export PYLIBCUGRAPH_FILE=`conda build --croot ${CONDA_BLD_DIR} conda/recipes/pylibcugraph --python=$PYTHON --output`
export CUGRAPH_FILE=`conda build --croot ${CONDA_BLD_DIR} conda/recipes/cugraph --python=$PYTHON --output`

################################################################################
# UPLOAD - Conda packages
################################################################################

gpuci_logger "Starting conda uploads"

if [[ "$BUILD_LIBCUGRAPH" == "1" && "$UPLOAD_LIBCUGRAPH" == "1" ]]; then
  test -e ${LIBCUGRAPH_FILE}
  echo "Upload libcugraph"
  echo ${LIBCUGRAPH_FILE}
  gpuci_retry anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_USERNAME:-rapidsai} ${LABEL_OPTION} --skip-existing ${LIBCUGRAPH_FILE} --no-progress
  test -e ${LIBCUGRAPH_ETL_FILE}
  echo "Upload libcugraph_etl"
  echo ${LIBCUGRAPH_ETL_FILE}
  gpuci_retry anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_USERNAME:-rapidsai} ${LABEL_OPTION} --skip-existing ${LIBCUGRAPH_ETL_FILE} --no-progress
fi

if [[ "$BUILD_CUGRAPH" == "1" ]]; then
  test -e ${PYLIBCUGRAPH_FILE}
  echo "Upload pylibcugraph"
  echo ${PYLIBCUGRAPH_FILE}
  gpuci_retry anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_USERNAME:-rapidsai} ${LABEL_OPTION} --skip-existing ${PYLIBCUGRAPH_FILE} --no-progress
  test -e ${CUGRAPH_FILE}
  echo "Upload cugraph"
  echo ${CUGRAPH_FILE}
  gpuci_retry anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_USERNAME:-rapidsai} ${LABEL_OPTION} --skip-existing ${CUGRAPH_FILE} --no-progress
fi
