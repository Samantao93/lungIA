library(TCGAbiolinks)
library(SummarizedExperiment)
library(dplyr)
setwd("~/cristina/Otros/phd/nuevo")

## Harmonized database: data aligned against hg38
## Clinical
luad_clin <- GDCquery(project = "TCGA-LUAD",data.category = "Clinical",data.type = "Clinical Supplement")
lusc_clin <- GDCquery(project = "TCGA-LUSC",data.category = "Clinical",data.type = "Clinical Supplement")
GDCdownload(luad_clin)
GDCdownload(lusc_clin)
luad_clin_data <- GDCprepare(luad_clin)
lusc_clin_data <- GDCprepare(lusc_clin)

clinical <- plyr::rbind.fill(luad_clin_data,lusc_clin_data)
write.table(clinical,"./clinica_combinada.csv",row.names = F,na="",sep=";")

## Bioespecimen
luad_clin_bio <- GDCquery(project = "TCGA-LUAD",data.category = "Biospecimen",data.type = 'Biospecimen Supplement')
lusc_clin_bio <- GDCquery(project = "TCGA-LUSC",data.category = "Biospecimen",data.type = 'Biospecimen Supplement')
GDCdownload(luad_clin_bio, files.per.chunk = 25)
GDCdownload(lusc_clin_bio, files.per.chunk = 25)
luad_clin_bio_data <- GDCprepare(luad_clin_bio)
lusc_clin_bio_data <- GDCprepare(lusc_clin_bio)

biospecimens <- plyr::rbind.fill(luad_clin_bio_data,lusc_clin_bio_data)
biospecimens <- apply(biospecimens,2,as.character)
write.csv(biospecimens,"./biospecimens_combinada.csv")

## SNV
query_luad_snv <- GDCquery(project = "TCGA-LUAD", 
                           data.category = "Simple Nucleotide Variation",
                           data.type = "Masked Somatic Mutation",
                           access="open"
)

GDCdownload(query_luad_snv, files.per.chunk = 25)
luad_snv <- GDCprepare(query_luad_snv)
write.table(luad_snv,"./luad_snv_completo.csv",row.names = F,na="",sep=";")

luad_snv2<-select(luad_snv,Hugo_Symbol,Variant_Type,HGVSc,HGVSp)
write.table(luad_snv2,"./luad_snv.csv",row.names = F,na="",sep=";") 

query_lusc_snv <- GDCquery(project = "TCGA-LUSC", 
                           data.category = "Simple Nucleotide Variation",
                           data.type = "Masked Somatic Mutation",
                           access="open"
)

GDCdownload(query_lusc_snv, files.per.chunk = 25)
lusc_snv <- GDCprepare(query_lusc_snv)
write.table(lusc_snv,"./lusc_snv_completo.csv",row.names = F,na="",sep=";")

lusc_snv2<-select(lusc_snv,Hugo_Symbol,Variant_Type,HGVSc,HGVSp)
write.table(lusc_snv2,"./GDCdata/lusc_snv.csv",row.names = F,na="",sep=";")


## Image slide
luad_slides <- GDCquery(project = "TCGA-LUAD",data.category = "Biospecimen",data.type = "Slide Image",access = 'open')
GDCdownload(luad_slides, files.per.chunk = 1)
crislide_metadata_luad <- GDCprepare(luad_slides)

lusc_slides <- GDCquery(project = "TCGA-LUSC",data.category = "Biospecimen",data.type = "Slide Image",access = 'open')
GDCdownload(lusc_slides, files.per.chunk = 1)
slide_metadata_lusc <- GDCprepare(lusc_slides)

