SRC = src/options.cpp src/communicator.cpp src/matrix.cpp src/misc.cpp src/genotype.cpp src/reml.cpp src/gwas.cpp src/covariancematrix.cpp src/phenotype.cpp src/covariate.cpp src/auxiliar.cpp src/simulatephenotype.cpp src/range.cpp src/message.cpp src/pca.cpp src/results.cpp src/analysis.cpp src/predictphenotype.cpp src/test.cpp src/main.cpp src/singlereml.cpp src/multireml.cpp src/kernel.cpp src/blockmatrix.cpp src/accuracybysnp.cpp src/labeledmatrix.cpp src/groupeffects.cpp src/genotypebgen.cpp src/glm.cpp src/glmm.cpp src/pcagentemp.cpp src/igwas.cpp src/mpresiduals.cpp src/gwasmp.cpp #finetest.cpp
HDR = include/global.h include/communicator.h include/main.h include/options.h include/matrix.h include/misc.h include/genotype.h include/reml.h include/gwas.h include/covariancematrix.h include/phenotype.h include/covariate.h include/auxiliar.h include/simulatephenotype.h include/range.h include/message.h include/pca.h include/results.h include/analysis.h include/predictphenotype.h include/test.h include/singlereml.h include/multireml.h include/kernel.h include/blockmatrix.h include/accuracybysnp.h include/labeledmatrix.h include/groupeffects.h include/glm.h include/glmm.h include/pcagentemp.h include/igwas.h include/mpresiduals.h #finetest.h

# DEP = ${SRC:.cpp=.d}

CXX = /opt/intel/compilers_and_libraries_2020.0.166/linux/mpi/intel64/bin/mpiicpc

CPPFLAGS = -I/run/media/nwknoblauch/Backup412/spack/opt/spack/linux-manjaro19-haswell/gcc-9.3.0/boost-1.72.0-nxjxgnomp5kanuuxgvjjvg4ykxdzkhfz/include -I/run/media/nwknoblauch/Backup412/spack/opt/spack/linux-manjaro19-haswell/gcc-9.3.0/bgen17-master-3notwqaxvpxfmm55dafuwyfk23fwyvxw/include/
CXXFLAGS += -g -O3 -fopenmp -m64 -DBOOSTLIB -DZLIB -DBGEN -march=native -mtune=native -I./include

LDFLAGS = -g -L/opt/intel/mkl/lib/intel64 -L/run/media/nwknoblauch/Backup412/spack/opt/spack/linux-manjaro19-haswell/gcc-9.3.0/bgen17-master-3notwqaxvpxfmm55dafuwyfk23fwyvxw/lib/

LDLIBS =  -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_blacs_intelmpi_lp64 -lmkl_core -lmkl_gnu_thread -lboost_iostreams -lbgenlib -lz -lzstd

LDLIBS += -ldl -lpthread -lm

# -include ${DEP}

# options.o: options.cpp options.h misc.h auxiliar.h

OBJ = $(SRC:.cpp=.o)

# $(OBJ) : $(HDR)

dissect : $(HDR) ${OBJ}
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o dissect $(OBJ) $(LDLIBS)

.PHONY: install
install: dissect
	mkdir -p $(DESTDIR)$(PREFIX)bin
	cp $< $(DESTDIR)$(PREFIX)bin/dissect


clean:
	${RM} ${OBJ}   # remove object files
	${RM} dissect     # remove main program
