# Bash script to get Protein Coding Genes names from the mouse Gencode file. I used this for examples http://www.gencodegenes.org/gencodeformat.html

#Using awk to get all gene annotations for protein coding mouse genes
awk '{if($3=="gene" && $12=="\"protein_coding\";"){print $0}}' gencode.vM7.annotation.gtf  > allMouseProteinCodingGeneAnnotations.gtf

#Counting number of genes. Is consistent with what is on gencode website
wc -l allMouseProteinCodingGeneAnnotations.gtf >file
cat file
rm file
#Getting protein coding mouse gene names and storing them in a csv file
awk '{print $16}' allMouseProteinCodingGeneAnnotations.gtf > allMouseProteinCodingGeneNames.csv


