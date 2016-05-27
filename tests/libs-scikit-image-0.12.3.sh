python <<EOF
from skimage import data, io, filters
image = data.coins()
edges = filters.sobel(image)
io.imsave("test.png",edges)
EOF
