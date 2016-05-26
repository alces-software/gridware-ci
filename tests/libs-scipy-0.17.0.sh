python <<EOF
from scipy import special, optimize
f = lambda x: -special.jv(3, x)
sol = optimize.minimize(f, 1.0)
x = linspace(0, 10, 5000)
print x
EOF
