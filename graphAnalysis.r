
humanGraph=read.csv("graph_outputHumanAfterBugFix.csv",header=TRUE)
#Labeling both columns and rows
rownames(humanGraph)=colnames(humanGraph)

mouseGraph=read.csv("graph_outputMouseAfterBugFix.csv",header=TRUE)
#Labeling both column and rows
rownames(mouseGraph)=colnames(mouseGraph)

humanGraphLogical=(humanGraph!=0)
#Setting Diagonal equal to false. We are not interested in self edges.
diag(humanGraphLogical)=FALSE

mouseGraphLogical=(mouseGraph!=0)
#Setting Diagonal equal to false. We are not interested in self edges.
diag(mouseGraphLogical)=FALSE


#Each cell of this graph will return a True value only if that edge is present in both graphs
intersectGraphLogical=((humanGraphLogical+mouseGraphLogical)>1)
#Setting Diagonal equal to false. We are not interested in self edges.
diag(intersectGraphLogical)=FALSE

intersectEdgeDistribution=apply(intersectGraphLogical,2,sum)
pdf("distributionOfGraphIntersect.pdf")
hist(intersectEdgeDistribution,50)
dev.off()

sink("graphAnalysisOutput.txt")
humanSparsity=sum(humanGraphLogical)/(nrow(humanGraphLogical)*ncol(humanGraphLogical))
print("Human Graph Sparsity:")
print(humanSparsity)
mouseSparsity=sum(mouseGraphLogical)/(nrow(mouseGraphLogical)*ncol(mouseGraphLogical))
print("Mouse Graph Sparsity:")
print(mouseSparsity)
intersectSparsity=sum(intersectGraphLogical)/(nrow(intersectGraphLogical)*ncol(intersectGraphLogical))
print("Intersect Graph Sparsity:")
print(intersectSparsity)

print("Total Number of Edges in Intersect graph:")
print(sum(intersectGraphLogical))

library('igraph')

intersectIGraph=graph.adjacency(intersectGraphLogical, mode = c("undirected"), weighted = NULL, diag=FALSE)

#Most of the cliques have 2 vetices. I get 29 groups with 3 or more vertices. Lets see what these are:
intersectGraphCliques=max_cliques(intersectIGraph,min=3,file="intersectGraphCliques.txt")
cliqueData=read.table("intersectGraphCliques.txt",header=FALSE)
geneNames=colnames(intersectGraphLogical)
cliqueNames=apply(cliqueData,1,function(rownumbers){
    return(geneNames[rownumbers])
})

cliqueNames=t(cliqueNames)
print(cliqueNames)
write.table(cliqueNames,"cliqueNames.csv", sep=",", quote=FALSE, row.names=FALSE)


