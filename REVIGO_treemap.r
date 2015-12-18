

# A treemap R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","freqInDbPercent","abslog10pvalue","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0007267","cell-cell signaling",3.768,17.9629,0.837,0.000,"cell-cell signaling"),
c("GO:0044700","single organism signaling",26.299,14.4459,0.824,0.427,"cell-cell signaling"),
c("GO:0023051","regulation of signaling",10.959,8.6978,0.773,0.555,"cell-cell signaling"),
c("GO:0035556","intracellular signal transduction",9.900,6.9336,0.735,0.540,"cell-cell signaling"),
c("GO:0010646","regulation of cell communication",11.000,7.8770,0.756,0.352,"cell-cell signaling"),
c("GO:0019722","calcium-mediated signaling",0.368,2.1945,0.817,0.391,"cell-cell signaling"),
c("GO:0007268","synaptic transmission",2.525,16.6307,0.788,0.283,"cell-cell signaling"),
c("GO:0050803","regulation of synapse structure and activity",0.292,2.9398,0.765,0.663,"cell-cell signaling"),
c("GO:0019932","second-messenger-mediated signaling",0.636,4.2373,0.807,0.236,"cell-cell signaling"),
c("GO:0007269","neurotransmitter secretion",0.463,7.3385,0.622,0.697,"cell-cell signaling"),
c("GO:1902531","regulation of intracellular signal transduction",6.150,2.3054,0.740,0.531,"cell-cell signaling"),
c("GO:0007215","glutamate receptor signaling pathway",0.390,4.2075,0.822,0.223,"cell-cell signaling"),
c("GO:0007610","behavior",3.381,2.7888,0.958,0.000,"behavior"),
c("GO:0044708","single-organism behavior",2.141,2.9922,0.904,0.179,"behavior"),
c("GO:0051716","cellular response to stimulus",28.763,3.1842,0.897,0.280,"behavior"),
c("GO:0010038","response to metal ion",0.925,2.2304,0.962,0.161,"behavior"),
c("GO:0042221","response to chemical",15.186,3.0845,0.951,0.414,"behavior"),
c("GO:0009987","cellular process",68.218,10.9361,0.995,0.000,"cellular process"),
c("GO:0023052","signaling",26.299,14.4020,0.989,0.000,"signaling"),
c("GO:0032501","multicellular organismal process",30.741,5.2005,0.990,0.000,"multicellular organismal process"),
c("GO:0032502","developmental process",24.064,10.0071,0.989,0.000,"developmental process"),
c("GO:0044699","single-organism process",62.571,11.9521,0.995,0.000,"single-organism process"),
c("GO:0048878","chemical homeostasis",3.511,4.5275,0.831,0.000,"chemical homeostasis"),
c("GO:0048519","negative regulation of biological process",15.841,4.6501,0.859,0.304,"chemical homeostasis"),
c("GO:0048518","positive regulation of biological process",17.954,5.6056,0.857,0.319,"chemical homeostasis"),
c("GO:0051239","regulation of multicellular organismal process",9.620,9.1915,0.870,0.164,"chemical homeostasis"),
c("GO:0042592","homeostatic process",5.779,3.8689,0.830,0.585,"chemical homeostasis"),
c("GO:0050794","regulation of cellular process",43.146,8.5543,0.799,0.256,"chemical homeostasis"),
c("GO:0050789","regulation of biological process",46.584,9.0987,0.844,0.452,"chemical homeostasis"),
c("GO:0001508","action potential",1.116,2.1945,0.859,0.463,"chemical homeostasis"),
c("GO:0042391","regulation of membrane potential",1.965,2.9144,0.850,0.499,"chemical homeostasis"),
c("GO:0065009","regulation of molecular function",9.358,3.6468,0.880,0.163,"chemical homeostasis"),
c("GO:0065008","regulation of biological quality",12.554,11.4858,0.875,0.134,"chemical homeostasis"),
c("GO:0050896","response to stimulus",36.212,5.7223,0.991,0.000,"response to stimulus"),
c("GO:0051179","localization",22.125,10.3027,0.989,0.000,"localization"),
c("GO:0065007","biological regulation",49.068,11.4008,0.993,0.000,"biological regulation"),
c("GO:0071840","cellular component organization or biogenesis",20.072,7.4257,0.989,0.000,"cellular component organization or biogenesis"),
c("GO:0006836","neurotransmitter transport",0.667,9.1136,0.792,0.042,"neurotransmitter transport"),
c("GO:0055085","transmembrane transport",5.190,5.2765,0.709,0.659,"neurotransmitter transport"),
c("GO:0051234","establishment of localization",17.684,10.6045,0.793,0.646,"neurotransmitter transport"),
c("GO:0006811","ion transport",6.369,5.1631,0.728,0.688,"neurotransmitter transport"),
c("GO:0006812","cation transport",4.496,5.9125,0.718,0.525,"neurotransmitter transport"),
c("GO:0010959","regulation of metal ion transport",0.989,2.5045,0.699,0.668,"neurotransmitter transport"),
c("GO:0044765","single-organism transport",14.037,11.5254,0.700,0.640,"neurotransmitter transport"),
c("GO:0032879","regulation of localization",7.172,5.3590,0.729,0.517,"neurotransmitter transport"),
c("GO:0006887","exocytosis",1.082,3.8728,0.720,0.430,"neurotransmitter transport"),
c("GO:1902578","single-organism localization",14.879,11.4703,0.740,0.449,"neurotransmitter transport"),
c("GO:0046903","secretion",3.577,6.0860,0.748,0.405,"neurotransmitter transport"),
c("GO:0060341","regulation of cellular localization",3.169,3.1158,0.689,0.541,"neurotransmitter transport"),
c("GO:0017157","regulation of exocytosis",0.471,3.1998,0.692,0.697,"neurotransmitter transport"),
c("GO:0097479","synaptic vesicle localization",0.427,2.7272,0.824,0.432,"neurotransmitter transport"),
c("GO:0051641","cellular localization",9.280,7.3826,0.812,0.549,"neurotransmitter transport"),
c("GO:0008104","protein localization",6.994,3.3460,0.814,0.515,"neurotransmitter transport"),
c("GO:0031175","neuron projection development",3.242,17.3841,0.563,0.083,"neuron projection development"),
c("GO:0044707","single-multicellular organism process",29.673,5.5855,0.797,0.352,"neuron projection development"),
c("GO:0048522","positive regulation of cellular process",15.830,4.0471,0.790,0.498,"neuron projection development"),
c("GO:0007399","nervous system development",8.920,17.4250,0.692,0.459,"neuron projection development"),
c("GO:0050890","cognition",1.098,2.0142,0.867,0.215,"neuron projection development"),
c("GO:0016043","cellular component organization",19.647,7.5926,0.851,0.551,"neuron projection development"),
c("GO:0051240","positive regulation of multicellular organismal process",2.203,3.2120,0.737,0.236,"neuron projection development"),
c("GO:0051961","negative regulation of nervous system development",0.010,3.2227,0.731,0.437,"neuron projection development"),
c("GO:0051962","positive regulation of nervous system development",0.114,3.8846,0.676,0.432,"neuron projection development"),
c("GO:0051960","regulation of nervous system development",2.722,10.7143,0.593,0.626,"neuron projection development"),
c("GO:0048869","cellular developmental process",16.173,11.2481,0.678,0.512,"neuron projection development"),
c("GO:0050793","regulation of developmental process",7.975,6.7361,0.696,0.363,"neuron projection development"),
c("GO:0050773","regulation of dendrite development",0.294,4.6925,0.579,0.669,"neuron projection development"),
c("GO:0060284","regulation of cell development",2.970,10.2644,0.580,0.654,"neuron projection development"),
c("GO:0051094","positive regulation of developmental process",3.468,2.3549,0.648,0.677,"neuron projection development"),
c("GO:0048468","cell development",8.894,14.7607,0.646,0.546,"neuron projection development"),
c("GO:0051128","regulation of cellular component organization",6.575,3.0188,0.775,0.590,"neuron projection development"),
c("GO:0030030","cell projection organization",4.817,14.3236,0.797,0.405,"neuron projection development"),
c("GO:0009653","anatomical structure morphogenesis",11.218,4.8637,0.744,0.540,"neuron projection development"),
c("GO:0048731","system development",19.050,9.6831,0.663,0.623,"neuron projection development"),
c("GO:0032990","cell part morphogenesis",3.220,11.2484,0.637,0.445,"neuron projection development"),
c("GO:0032989","cellular component morphogenesis",5.363,7.2890,0.639,0.611,"neuron projection development"),
c("GO:0044763","single-organism cellular process",54.297,12.3513,0.869,0.090,"single-organism cellular process"),
c("GO:0007154","cell communication",26.729,12.7470,0.851,0.182,"single-organism cellular process"),
c("GO:0045936","negative regulation of phosphate metabolic process",1.401,2.0949,0.839,0.095,"negative regulation of phosphate metabolism"),
c("GO:0048523","negative regulation of cellular process",14.287,2.8665,0.811,0.499,"negative regulation of phosphate metabolism"),
c("GO:0006796","phosphate-containing compound metabolic process",16.617,4.9386,0.905,0.490,"negative regulation of phosphate metabolism"),
c("GO:0006793","phosphorus metabolic process",16.763,4.7128,0.927,0.158,"negative regulation of phosphate metabolism"),
c("GO:0010563","negative regulation of phosphorus metabolic process",1.401,2.0949,0.839,0.589,"negative regulation of phosphate metabolism"),
c("GO:0006468","protein phosphorylation",6.709,3.6336,0.915,0.661,"negative regulation of phosphate metabolism"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$abslog10pvalue <- as.numeric( as.character(stuff$abslog10pvalue) );
stuff$freqInDbPercent <- as.numeric( as.character(stuff$freqInDbPercent) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
tmPlot(
	stuff,
	index = c("representative","description"),
	vSize = "abslog10pvalue",
	type = "categorical",
	vColor = "representative",
	title = "REVIGO Gene Ontology treemap",
	inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
	lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
	bg.labels = "#CCCCCCAA",     # define background color of group labels
												       # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
	position.legend = "none"
)

dev.off()
