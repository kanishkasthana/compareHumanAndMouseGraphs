
humanGraph=read.csv("graph_outputHumanAfterBugFix.csv",header=TRUE)
#Labeling both columns and rows
rownames(humanGraph)=colnames(humanGraph)
#Temporarily taking only a subset of the graphs for writting the program
#humanGraph=humanGraph[1:1000,1:1000]
gc()#Garbage Collection to free up memory
mouseGraph=read.csv("graph_outputMouseAfterBugFix.csv",header=TRUE)
#Labeling both column and rows
rownames(mouseGraph)=colnames(mouseGraph)
#Temporarily taking only a subset of the graphs for writting the program
#mouseGraph=mouseGraph[1:1000,1:1000]
gc()#Garbage Collection to free up memory

humanGraphLogical=(humanGraph!=0)
mouseGraphLogical=(mouseGraph!=0)
#Each cell of this graph will return a True value only if that edge is present in both graphs
intersectGraphLogical=((humanGraphLogical+mouseGraphLogical)>1)
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

intersectGraphCliques=max_cliques(intersectIGraph,min=2,file="intersectGraphCliques.txt")


