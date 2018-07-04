# intensity matrix 

flower <- read.csv("flowers.csv", header = FALSE) #as there is no header in the file

str(flower)

# data does not look like an intensity matrix so use as.matrix to changes it as amatrix structure

flowerMatrix = as.matrix(flower)

str(flowerMatrix) # shows 50:50 matrix

# divide it into clusters 
flowerVector = as.vector(flowerMatrix) # it has values between 0 to 1

str(flowerVector) # has 2500 values between 0 to 1, as we have 50 * 50 intensity values in our matrix.

# calulate the distance

distance = dist(flowerVector, method = "euclidean")

# now calculate hierearchical distance
clusterIntensity = hclust(distance, method = "ward")

#plot a cluster dendrogram
plot(clusterIntensity)

#draw a rectangle to select clusters in red
rech.hclust(clusterIntensity, k=3, border="red")

#cut the clusters here in 3 parts
flowerClusters = cutree(clusterIntensity, k=3)

# use tapply to fine mean intensity value of each of our cluster
tapply(flowerVector, flowerClusters, mean) # 1 closest to 0 shows darkest image and 3 closest to 1 shows fairest shade

# convert flowercluster into metrix using diamension function
dim(flowerClusters) = c(50,50)

# image using flowerClusters
image(flowerClusters, axes = FALSE)

#use flowerMatrix to get grey image
image(flowerMatrix, axex = FALSE, col = grey(seq(0,1,length=256))) # this image has very low resolution.
