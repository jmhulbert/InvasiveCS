#open some packages
require(ggplot2)
require(stringr)

CS <-read.csv("InvasiveCitSciProjectDB5.csv") #read in the data file
CS2 <-CS[!duplicated(CS$Title), ]#remove duplicates
#clean data a bit
CS2$Invasive <-str_replace_all(CS2$Invasive,"Insects","Invertebrates")
CS2$Invasive <-str_replace_all(CS2$Invasive,"Diseases","Pests & Diseases")
CS2$Invasive <-str_replace_all(CS2$Invasive,"Pests & Pests & Diseases","Pests & Diseases")
CSactive <-subset(CS2,Active=="Active") #Subset to active projects only 
#Define order of sclaes in plot
xlevels <-c("Local","Regional","National","Continental","Global") 
ylevels <-c("Multiple","Pests & Diseases", "Plants","Vertebrates","Invertebrates","Algea/Seaweed")

#Plot the data
ggplot(CSactive,aes(x=Scale.,fill=Invasive)) +geom_bar()+ facet_grid(Environment~.) + scale_x_discrete(limits = xlevels) +scale_fill_grey(ylevels,name=expression(paste("Invasive Species"^"3"))) +coord_flip() +labs(x=expression(paste("Project Scale"^"2")), y=expression(paste("Number of Projects"^"1")))
