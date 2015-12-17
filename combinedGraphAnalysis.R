#Script written by Kanishk Asthana to compare the human and mouse graphs
humanLogicalGraph=read.csv("humanLogicalGraph.csv", header=TRUE)
mouseLogicalGraph=read.csv("graph_outputMouse.csv", header=TRUE)
mouseGeneNamesInGraph=read.csv("geneNamesMouse.csv",header=FALSE,stringsAsFactors = FALSE)
#Unlisting to perform set operations
mouseGeneNamesInGraph=unlist(mouseGeneNamesInGraph)
humanGeneNamesInGraph=read.csv("geneNamesHuman.csv", header=FALSE, stringsAsFactors = FALSE)
#Unlisting to perform set operations
humanGeneNamesInGraph=unlist(humanGeneNamesInGraph)

#By convention human gene names are named in all Capital Letters and their mouse counterparts with only the
#first letter capitalized. See this link http://www.ncbi.nlm.nih.gov/books/NBK21060/#A5950
#To get a list of genes that is common to both mouse and human we will convert all mouse gene names to uppercase
# and then take the intersection of human and mouse gene names in the graph

mouseGeneNamesInGraphUPPERCASE=sapply(mouseGeneNamesInGraph,toupper)
#Taking intersection: 13261 common human and mouse genes. Nice!
commonMouseAndHumanGenes=intersect(humanGeneNamesInGraph,mouseGeneNamesInGraphUPPERCASE)


