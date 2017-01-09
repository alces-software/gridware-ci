cat << EOF > helloworld.cpp
#include <iostream>
#include <vector>
#include <opengv/Indices.hpp>
int main()
{
   std::cout << "Hello, World!";
   return 0;
}
EOF
if ! g++ helloworld.cpp -o helloworld.o -I${OPENGVINCLUDE} -I${EIGENINCLUDE}; then
  exit 1
fi
./helloworld.o
