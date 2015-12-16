#Using awk to get annotations for human protein coding genes
awk '{if($3=="gene" && $14=="\"protein_coding\";"){print $0}}' gencode.v20.annotation.gtf > allHumanProteinCodingGeneAnnotations.gtf

#The above number matches with Gencode statistics
awk '{print $18}' allHumanProteinCodingGeneAnnotations.gtf > allHumanProteinCodingGeneNames.csv
