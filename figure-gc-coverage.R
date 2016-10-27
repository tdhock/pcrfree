works_with_R("3.3.1",
             data.table="1.9.7",
             "tdhock/animint@78974d8788930034109289e42f8c90f1ee804290")

load("gc.coverage.RData")

cov.wide <- dcast(gc.coverage, sample + gcProp + chr + binStart ~ protocol, value.var="coverage")

##                  PCR PCRFree
## B00BF6R            1       1
## B00BF6V            1       1
## B00BF72            1       1
## B00BF85            1       1
## B00BF86            0       1
## B00BF89            1       1
## B00BF8G            1       1
## MGH1175620_Tumor   1       1

ggplot()+
  theme_bw()+
  theme(panel.margin=grid::unit(0, "lines"))+
  facet_wrap("sample")+
  geom_point(aes(
    PCR, PCRFree, color=gcProp),
             data=cov.wide[sample!="B00BF86",])

gg <- ggplot()+
  theme_bw()+
  theme(panel.margin=grid::unit(0, "lines"))+
  facet_wrap("sample")+
  scale_color_gradient(low="black", high="red")+
  geom_point(aes(
    log10(PCR), log10(PCRFree), color=gcProp),
             data=cov.wide[sample!="B00BF86",],
             shape=1)+
  coord_equal()+
  geom_abline(slope=1, intercept=0)

png("figure-gc-coverage.png")
print(gg)
dev.off()
