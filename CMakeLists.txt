cmake_minimum_required (VERSION 3.15)
project (dissect CXX)
set(default_build_type "Release")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/modules/")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/")
include(CheckLibraryExists)
include(LibraryUtils)
include(CheckLinkerFlag)
set(DISSECT_MAJOR_VERSION 0)
set(DISSECT_MINOR_VERSION 1)
set(DISSECT_PATCH_VERSION 1)
set(DISSECT_VERSION
  ${DISSECT_MAJOR_VERSION}.${DISSECT_MINOR_VERSION}.${DISSECT_PATCH_VERSION})


SET(CMAKE_SKIP_BUILD_RPATH  FALSE)
# when building, don't use the install RPATH already
# (but later on when installing)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)

# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

find_package(PkgConfig)
find_package(PkgConfig QUIET)
pkg_check_modules(ZSTD REQUIRED IMPORTED_TARGET GLOBAL libzstd)

# FetchContent_Declare(
#   zstd
#   GIT_REPOSITORY https://github.com/facebook/zstd.git
#   SOURCE_SUBDIR "build/cmake/"
#   )

# FetchContent_MakeAvailable(zstd)
# the RPATH to be used when installing, but only if it's not a system directory
LIST(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
IF("${isSystemDir}" STREQUAL "-1")
   SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
ENDIF("${isSystemDir}" STREQUAL "-1")



find_package(Boost REQUIRED COMPONENTS iostreams)
find_package(ZLIB REQUIRED)


add_executable(dissect
  src/options.cpp
  src/communicator.cpp
  src/matrix.cpp
  src/misc.cpp
  src/genotype.cpp
  src/reml.cpp
  src/gwas.cpp
  src/covariancematrix.cpp
  src/phenotype.cpp
  covariate.cpp
  src/auxiliar.cpp
  src/simulatephenotype.cpp
  src/range.cpp
  src/message.cpp
  src/pca.cpp
  src/results.cpp
  src/analysis.cpp
  src/predictphenotype.cpp
  src/test.cpp
  src/main.cpp
  src/singlereml.cpp
  src/multireml.cpp
  src/kernel.cpp
  src/blockmatrix.cpp
  src/accuracybysnp.cpp
  src/labeledmatrix.cpp
  src/groupeffects.cpp
  src/glm.cpp
  src/glmm.cpp
  src/pcagentemp.cpp
  src/igwas.cpp
  src/mpresiduals.cpp
  src/gwasmp.cpp
  src/genotypebgen.cpp
  include/global.h include/communicator.h include/main.h include/options.h include/matrix.h include/misc.h include/genotype.h include/reml.h include/gwas.h include/covariancematrix.h include/phenotype.h include/covariate.h include/auxiliar.h include/simulatephenotype.h include/range.h include/message.h include/pca.h include/results.h include/analysis.h include/predictphenotype.h include/test.h include/singlereml.h include/multireml.h include/kernel.h include/blockmatrix.h include/accuracybysnp.h include/labeledmatrix.h include/groupeffects.h include/glm.h include/glmm.h include/pcagentemp.h include/igwas.h include/mpresiduals.h)

target_compile_definitions(dissect PRIVATE BOOSTLIB PRIVATE ZLIB PRIVATE BGEN)

find_package(MPI REQUIRED)
message(STATUS "Run: ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} ${MPIEXEC_PREFLAGS} EXECUTABLE ${MPIEXEC_POSTFLAGS} ARGS")
find_package(LAPACK REQUIRED)
find_package(BLAS REQUIRED)
find_package(bgen REQUIRED)

target_link_libraries(dissect PUBLIC MPI::MPI_CXX)
target_link_libraries(dissect PRIVATE bgen17)
target_include_directories(dissect PRIVATE SCALAPACK_INCDIR)
target_link_libraries(dissect PRIVATE SCALAPACK_LIBRARIES)
