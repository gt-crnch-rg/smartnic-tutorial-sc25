#!/bin/sh

. env.sh

CLANG_PATH=$PKG/odos/
#MPI_PATH=/global/scratch/users/uthmanhere/ompi/ompi_x86_64/install/
#MPI_PATH=/global/scratch/users/uthmanhere/ompi_remote_x86_64/install/
MPI_PATH=$PKG/ompi/ref/x86_64
PNETCDF_PATH=$PKG/pnetcdf

. env.sh

export LD_LIBRARY_PATH=$MPI_PATH/lib:$LD_LIBRARY_PATH
export OPAL_PREFIX=$MPI_PATH

cd task_a && cd build && cmake .. -DCLANG_PATH=$CLANG_PATH && make 
cp ./hello ../../out/tasks/a_hello && cd ../../
cd task_b && cd build && cmake .. -DCLANG_PATH=$CLANG_PATH && make 
cp ./omp_parallel ../../out/tasks/b_omp_parallel && cd ../../
cd task_c && sh compile.sh $CLANG_PATH
cp ./build/lib* ../out/tasks/  && cp ./build/shared ../out/tasks/c_shared && cd ../
cd task_d && cd build && cmake .. -DCLANG_PATH=$CLANG_PATH && make
cp ./net_accel ../../out/tasks/d_net_accel && cd ../../

cd omb-odos/mpi_odos/

cd pt2pt/      && . compile.sh $CLANG_PATH $MPI_PATH
mv b* l* m* ../../../out/omb/pt2pt/ && cd ../

cd one-sided/  && . compile.sh $CLANG_PATH $MPI_PATH
mv a* f* cas* g* p* ../../../out/omb/one-sided/ && cd ../

cd collective/ && . compile.sh $CLANG_PATH $MPI_PATH
mv a* s* r* i* g* ../../../out/omb/collective/ && cd ../../../


cd miniweather/odos/ && . compile_omp.sh $CLANG_PATH $MPI_PATH $PNETCDF_PATH
mv miniWeather_mpi_omp miniWeather_mpi_odos_omp ../../out/miniweather && cd ../../

