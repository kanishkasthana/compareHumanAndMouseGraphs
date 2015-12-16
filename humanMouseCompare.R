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