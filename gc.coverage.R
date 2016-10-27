works_with_R(
  "3.3.1",
  data.table="1.9.7",
  "tdhock/namedCapture@05175927a45c301a18e8c6ebae67ea39a842d264")

txt.vec <- Sys.glob("/mnt/abaproject/mugqic/projects/alfredo_pcrfree_techdev_31/alignment/*/*.sorted.dup.recal.bam.depth.txt")

pattern <- paste0(
  "(?<sample>.*)",
  "_",
  "(?<type>PCR(?:Free)?)")
sample.mat <- str_match_named(basename(dirname(txt.vec)), pattern)
table(sample.mat[, "sample"], sample.mat[, "type"])

gc.coverage.list <- list()
for(file.i in seq_along(txt.vec)){
  txt <- txt.vec[[file.i]]
  meta <- sample.mat[file.i,]
  bins <- fread(txt, colClasses=list("NULL"=6:8))
  setnames(bins, c("chr", "binStart", "binEnd", "coverage", "gcProp"))
  gc.coverage.list[[txt]] <- data.table(
    sample=meta[["sample"]],
    protocol=meta[["type"]],
    bins)
}
gc.coverage <- do.call(rbind, gc.coverage.list)


##freadc("NULL"=6:8)
##  chr, start, end, coverage, gc, mean, stdev, zscore

save(gc.coverage, file="gc.coverage.RData")
