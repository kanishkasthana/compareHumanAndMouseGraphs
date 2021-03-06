#RScript created by Kanishk Asthana to compare human and mouse graphs
mouseGeneNamesInGraph=read.csv("geneNamesMouse.csv",header=FALSE,stringsAsFactors = FALSE)
#Reading and cleaning mouse Protein Gene names
data=read.csv("allMouseProteinCodingGeneNames.csv", header=FALSE, sep=";", stringsAsFactors = FALSE)
allMouseProteinCodingGeneNames=data[,1]
mouseGeneNamesInGraph=unlist(mouseGeneNamesInGraph)

#Getting Intersect between mouse Protein Coding Genes and genes in mouse single cell graph
geneIntersect=intersect(allMouseProteinCodingGeneNames,mouseGeneNamesInGraph)
#It seems like not all genes are protein coding!~87% protein Coding Genes. Its fine
print("Percentage of Protein Coding Genes:")
print(100*length(geneIntersect)/length(mouseGeneNamesInGraph))

humanGeneNamesInGraph=read.csv("geneNamesHuman.csv", header=FALSE, stringsAsFactors = FALSE)
humanGeneNamesInGraph=unlist(humanGeneNamesInGraph)
data=read.csv("allHumanProteinCodingGeneNames.csv", header = FALSE, sep = ";", stringsAsFactors = FALSE)
allHumanProteinCodingGeneNames=data[,1]

#Getting Intersect between human protein coding genes and genes in human single cell graph
geneIntersectHuman=intersect(as.character(humanGeneNamesInGraph),allHumanProteinCodingGeneNames)
#It seems like all Human Genes in the graph are protein coding.
print("All human genes are protein coding:")
print(identical(as.character(humanGeneNamesInGraph), geneIntersectHuman))
#By convention human gene names are named in all Capital Letters and their mouse counterparts with only the
#first letter capitalized. See this link http://www.ncbi.nlm.nih.gov/books/NBK21060/#A5950
#To get a list of genes that is common to both mouse and human we will convert all mouse gene names to uppercase
# and then take the intersection of human and mouse gene names in the graph

mouseGeneNamesInGraphUPPERCASE=sapply(mouseGeneNamesInGraph,toupper)
#Taking intersection: 13261 common human and mouse genes. Nice!
commonMouseAndHumanGenes=intersect(humanGeneNamesInGraph,mouseGeneNamesInGraphUPPERCASE)

mouseGraph=read.csv("graph_outputMouse.csv", header=TRUE)

logicalMouseGraph=mouseGraph!=0
#Freeing Memory
rm(mouseGraph)
gc()
write.table(logicalMouseGraph,"mouseLogicalGraph.csv", sep=",", quote=FALSE, row.names=FALSE)

#Freeing Up memory
rm(logicalMouseGraph)
gc()
humanGraph=read.csv("graph_outputHuman.csv", header=TRUE)

logicalHumanGraph=humanGraph!=0
#Freeing Memory
rm(humanGraph)
gc()
write.table(logicalHumanGraph,"humanLogicalGraph.csv",sep=",", quote=FALSE, row.names=FALSE)
rm(logicalHumanGraph)
gc()

