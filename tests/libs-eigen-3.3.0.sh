cat << EOF > helloworld.cpp
#include <stdio.h>
#include <Eigen/Dense>
int main()
{
   printf("Hello, World!");
   return 0;
}
EOF
if ! g++ helloworld.cpp -o helloworld.o -I${EIGENINCLUDE}; then
  exit 1
fi
./helloworld.o
