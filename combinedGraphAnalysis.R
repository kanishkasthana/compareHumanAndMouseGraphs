#Script written by Kanishk Asthana to compare the human and mouse graphs
humanLogicalGraph=read.csv("humanLogicalGraph.csv", header=TRUE)
mouseLogicalGraph=read.csv("graph_outputMouse.csv", header=TRUE)
mouseGeneNamesInGraph=read.csv("geneNamesMouse.csv",header=FALSE)
#Unlisting to perform set operations
mouseGeneNamesInGraph=unlist(mouseGeneNamesInGraph)
humanGeneNamesInGraph=read.csv("geneNamesHuman.csv", header=FALSE)
#Unlisting to perform set operations
humanGeneNamesInGraph=unlist(humanGeneNamesInGraph)

#By convention human gene names are named in all Capital Letters and their mouse counterparts with only the
#first letter capitalized. See this link http://www.ncbi.nlm.nih.gov/books/NBK21060/#A5950
#To get a list of genes that is common to both mouse and human we will convert all mouse gene names to uppercase
# and then take the intersection of human and mouse gene names in the graph

mouseGeneNamesInGraphUPPERCASE=as.factor(sapply(mouseGeneNamesInGraph,toupper))
#Taking intersection: 13261 common human and mouse genes. Nice!
commonMouseAndHumanGenes=as.factor(intersect(humanGeneNamesInGraph,mouseGeneNamesInGraphUPPERCASE))
humanLogicalGraphIntersectWithMouse=humanLogicalGraph[,commonMouseAndHumanGenes]

#Converting Column names in mouseLogicalGraph data.frame to uppercase for ease with indexing
colnames(mouseLogicalGraph)=as.factor(sapply(colnames(mouseLogicalGraph),toupper))
mouseLogicalGraphIntersectWithHuman=mouseLogicalGraph[,commonMouseAndHumanGenes]

print("Dimensions of human graph intersect:")
print(dim(humanLogicalGraphIntersectWithMouse))

print("Dimensions of mouse graph intersect:")
print(dim(mouseLogicalGraphIntersectWithHuman))
#Note: Hmmm the dimensions are working as expected. Cool

#Plotting some features of the graph. I expect to see a power law. Lets see what happens.

vectorForNumberOfEdgesHuman=apply(humanLogicalGraphIntersectWithMouse,2,sum)
vectorForNumberOfEdgesMouse=apply(mouseLogicalGraphIntersectWithHuman,2,sum)

pdf("EdgeDistributionForHumanAndMouseGraphIntersects.pdf")
hist(vectorForNumberOfEdgesMouse,200,main="Histogram of Edge distribution of Mouse Graph Intersect", xlab="Number of Edges", ylab="Frequency of Nodes")
hist(vectorForNumberOfEdgesHuman,200,main="Histogram of Edge distribution of Human Graph Intersect", xlab="Number of Edges", ylab="Frequency of Nodes")
dev.off()