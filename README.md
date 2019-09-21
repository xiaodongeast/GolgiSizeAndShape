### Part1. Calculate Golgi to centrosome distance:

(1). Images in each time point are saved as individual z-stacks and are in one folder. (2) Run image J macro to retrive all the Golgi pixels in the Z-stack of images. (3). Centrosome location is first detected with Imaris. (4). Matlab code is then used to correct the detection, based on the cell cycle stages. Kmeans clustering is then used find two centers as the position of the centrosome.  (5) Golgi centrosome distances at each time in 3D are then calculated, and presented as a movie.

### Part2. Calculate Golgi shape: 

two parameters are used: Compactness is calculated after Kmeans clustering. Average distance between any two pixels in the Golgi is also used.

