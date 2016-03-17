
mouseGraph=read.csv("graph_outputMouse.csv",header=TRUE)
mouseGraphLogical=(mouseGraph!=0)
sparsity=sum(mouseGraphLogical)/(nrow(mouseGraph)*ncol(mouseGraph))
print(sparsity)


