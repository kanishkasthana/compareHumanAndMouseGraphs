#Script written by Kanishk Asthana to compare the human and mouse graphs
humanLogicalGraph=read.csv("humanLogicalGraph.csv", header=TRUE)
mouseLogicalGraph=read.csv("mouseLogicalGraph.csv", header=TRUE)

#Setting Diagonal of Both LogicalGraphs to FALSE. i.e. We are ignoring self edges.
diag(humanLogicalGraph)=FALSE
diag(mouseLogicalGraph)=FALSE
mouseGeneNamesInGraph=read.csv("geneNamesMouse.csv",header=FALSE)

#Unlisting to perform set operations
mouseGeneNamesInGraph=unlist(mouseGeneNamesInGraph)
humanGeneNamesInGraph=read.csv("geneNamesHuman.csv", header=FALSE)
#Unlisting to perform set operations
humanGeneNamesInGraph=as.factor(unlist(humanGeneNamesInGraph))

#By convention human gene names are named in all Capital Letters and their mouse counterparts with only the
#first letter capitalized. See this link http://www.ncbi.nlm.nih.gov/books/NBK21060/#A5950
#To get a list of genes that is common to both mouse and human we will convert all mouse gene names to uppercase
# and then take the intersection of human and mouse gene names in the graph

mouseGeneNamesInGraphUPPERCASE=as.factor(sapply(mouseGeneNamesInGraph,toupper))
#Taking intersection: 13261 common human and mouse genes. Nice!
commonMouseAndHumanGenes=as.factor(intersect(humanGeneNamesInGraph,mouseGeneNamesInGraphUPPERCASE))

write.table(commonMouseAndHumanGenes,"commonMouseAndHumanGenes.csv",sep=",", row.names=FALSE,col.names=FALSE, quote=FALSE)

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

mHist=hist(vectorForNumberOfEdgesMouse,100,main="Histogram of Edge distribution of Mouse Graph Intersect", xlab="Number of Edges", ylab="Frequency of Nodes")
hHist=hist(vectorForNumberOfEdgesHuman,100,main="Histogram of Edge distribution of Human Graph Intersect", xlab="Number of Edges", ylab="Frequency of Nodes")

pdf("LogPlotForHistogramsEdgeDistrubutionMouseAndHumanGraphIntersect.pdf")
plot(mHist$breaks[2:length(mHist$breaks)],log(mHist$counts), type='S', xlab="Number of Edges", ylab="Log of Frequency of Nodes", main="Log plot of Histogram of Edge distribution of Mouse Graph Intersect")
plot(hHist$breaks[2:length(hHist$breaks)],log(hHist$counts), type='S', xlab="Number of Edges", ylab="Log of Frequency of Nodes", main="Log plot of Histogram of Edge distribution of Human Graph Intersect")
dev.off()
#Getting rid of the NA values fixed the problem. But the graph is still very sparse.

#Creating percentage vector
numberOfCommonEdgesVector=sapply(1:length(commonMouseAndHumanGenes),function(i){
  humanEdgesInGraph=humanGeneNamesInGraph[humanLogicalGraphIntersectWithMouse[,i]]
  mouseEdgesInGraph=mouseGeneNamesInGraphUPPERCASE[mouseLogicalGraphIntersectWithHuman[,i]]
  commonEdgesInGraphs=intersect(humanEdgesInGraph,mouseEdgesInGraph)
  return(length(commonEdgesInGraphs))
})

write.table(numberOfCommonEdgesVector,"commonEdgesVector.csv",sep=",",row.names=FALSE, col.names=FALSE, quote=FALSE)

commonHist=hist(numberOfCommonEdgesVector,50, main="Histogram of Common Edges Distribution for Human and Mouse Graphs", xlab="Number of Edges", ylab="Frequency of Nodes")
pdf("LogPlotForNumberOfCommonEdgesIntheHumanAndMouseGraphs.pdf")
plot(commonHist$breaks[2:length(commonHist$breaks)], log(commonHist$counts), type='S', xlab="Number of Edges", ylab="Log of Frequency of Nodes", main="Log plot of Histogram of Common Edges distribution for Human and Mouse Graphs")
dev.off()

neurologicalProcessGenes=read.csv("genesAssociateWithNeurologicalProcessesGoTerm.txt",sep=",",header=FALSE)

#Converting to Factor List for Indexing
neurologicalProcessGenes=as.factor(unlist(neurologicalProcessGenes))

#Getting complementary Set to neurological process genes
complementToNeurologicalProcessGenes=as.factor(setdiff(commonMouseAndHumanGenes,neurologicalProcessGenes))

#Subsetting graphs
neurologicalProcessHLGIWM=humanLogicalGraphIntersectWithMouse[,neurologicalProcessGenes]
neurologicalProcessMLGIWH=mouseLogicalGraphIntersectWithHuman[,neurologicalProcessGenes]

complementNeurologicalProcessHLGIWM=humanLogicalGraphIntersectWithMouse[,complementToNeurologicalProcessGenes]
complementNeurologicalProcessMLGIWH=mouseLogicalGraphIntersectWithHuman[,complementToNeurologicalProcessGenes]

