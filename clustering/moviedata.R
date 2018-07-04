#movies data - heirarchical clustering

movies = read.table("movieLens.txt", header = FALSE, sep = "|", quote = "\"")

str(movies)

#adding coloumn names

colnames(movies) = c("ID", "Title", "ReleaseDate", "VideoReleaseDate", "IMDB", "Unknown", "Action","Adventure", "Animation", "Children", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "FilmNoir", "Horror", "Musical", "Mystery", "Romance", "SciFi", "Thriller", "War", "Western")

str(movies)

#remove columns which we are not using
movies$ID = NULL
movies$ReleaseDate = NULL
movies$VideoReleaseDate = NULL
movies$IMDB = NULL

# remove duplicate entries
movies = unique(movies)

str(movies)

distances = dist(movies[2:20], method = "euclidean")

clusterMovies = hclust(distances, method = "ward")

#plot a cluster dendrogram

plot(clusterMovies)

#label data points according to which cluster it belongs to - select 10 clusters
clusterGroups = cutree(clusterMovies, k = 10)

#use tapply function to calculate % of movies in each jonhra and cluster

tapply(movies$Action, clusterGroups, mean) # divides data into 10 clusters and calculate avg value for each cluster - it shows 78% movies in cluster 2 are labeled as action and none of the movies in cluster 4 are action movies.

tapply(movies$Romance, clusterGroups, mean) # check for romance label - it shows all movies in cluster 6 and 7 are labeled as Romance movies

# calculate the % for all labels
action <- tapply(movies$Action, clusterGroups, mean)
adventure <- tapply(movies$Adventure, clusterGroups, mean)
animation <- tapply(movies$Animation, clusterGroups, mean)
children <- tapply(movies$Children, clusterGroups, mean)
comedy <- tapply(movies$Comedy, clusterGroups, mean)
crime <- tapply(movies$Crime, clusterGroups, mean)
documentary <- tapply(movies$Documentary, clusterGroups, mean)
drama <- tapply(movies$Drama, clusterGroups, mean)
fantasy <- tapply(movies$Fantasy, clusterGroups, mean)
filmnoir<- tapply(movies$FilmNoir, clusterGroups, mean)
horror <- tapply(movies$Horror, clusterGroups, mean)
musical <- tapply(movies$Musical, clusterGroups, mean)
mystery <- tapply(movies$Mystery, clusterGroups, mean)
romance <- tapply(movies$Romance, clusterGroups, mean)
scifi <- tapply(movies$SciFi, clusterGroups, mean)
thriller <- tapply(movies$Thriller, clusterGroups, mean)
war <- tapply(movies$War, clusterGroups, mean)
western <- tapply(movies$Western, clusterGroups, mean)

clustereddata <- data.frame(action,adventure,animation,children,comedy,crime,documentary,drama,fantasy,filmnoir,horror,musical,mystery,romance,scifi,thriller,war,western)

clustereddata <- t(clustereddata)

#colnames(clustereddata) <- c("Cluster 1","Cluster 2","Cluster 3","Cluster 4","Cluster 5","Cluster 6","Cluster 7","Cluster 8","Cluster 9","Cluster 10")

write.csv(clustereddata, "clusterdata.csv")

# lets find cluster for "Men in Black (1997)" movie
subset(movies, Title=="Men in Black (1997)") # it is on the 257th row

# lets find out which cluster does it belong to
clusterGroups[257] # cluster 2

# create a subset which has all the movies from cluster 2
cluster2 = subset(movies, clusterGroups == 2)

# look at the 1st 10 movie titles of subset cluster2 - these are the recommendation for the person who watched "Men in black" movie
cluster2$Title[1:10]
