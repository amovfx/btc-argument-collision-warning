#!/usr/bin/env bash

#Run in your bitcoin build git directory


BITCOIN_BUILD_DIR=${BITCOIN_BUILDDIR}
BITCOIN_GIT_DIR=${GITDIR}

CWD=$(pwd)

cd $BITCOIN_GIT_DIR
git checkout master
configure #these are my functions, you can just run ./configure
build #these are my functions, you can just run make -j N


cd $BITCOIN_BUILD_DIR
CHAIN_MERGE_TEST_OUT=/tmp/master_results.txt ${BITCOIN_BUILD_DIR}/src/test/test_bitcoin --run_test=util_tests/util_ChainMerge
export MASTER_CHAIN_MERGE_TEST_OUT=/tmp/master_results.txt


cd $BITCOIN_GIT_DIR
git checkout network-argument-collision-verbosity
configure #these are my functions, you can just run ./configure
build #these are my functions, you can just run make -j N

cd $BITCOIN_BUILD_DIR
CHAIN_MERGE_TEST_OUT=/tmp/network-argument-collision-verbosity_results.txt ${BITCOIN_BUILD_DIR}/src/test/test_bitcoin --run_test=util_tests/util_ChainMerge
export BRANCH_CHAIN_MERGE_TEST_OUT=/tmp/network-argument-collision-verbosity_results.txt


#diff ${MASTER_CHAIN_MERGE_TEST_OUT} ${BRANCH_CHAIN_MERGE_TEST_OUT}

python ${CWD}/compare_results.py ${MASTER_CHAIN_MERGE_TEST_OUT} ${BRANCH_CHAIN_MERGE_TEST_OUT}



#clean up files
rm $MASTER_CHAIN_MERGE_TEST_OUT
rm $BRANCH_CHAIN_MERGE_TEST_OUT

cd $CWD

