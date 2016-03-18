
humanGraph=read.csv("graph_outputHumanAfterBugFix.csv",header=TRUE)
mouseGraph=read.csv("graph_outputMouseAfterBugFix.csv",header=TRUE)
humanGraphLogical=(humanGraph!=0)
mouseGraphLogical=(mouseGraph!=0)
#Each cell of this graph will return a True value only if that edge is present in both graphs
intersectGraphLogical=((humanGraphLogical+mouseGraphLogical)>1)
intersectEdgeDistribution=apply(intersectGraphLogical,2,sum)
pdf("distributionOfGraphIntersect.pdf")
hist(intersectEdgeDistribution,100)

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

library('igraph')
