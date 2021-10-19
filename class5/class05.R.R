#' ---
#' title: "Class 05 Data Visualization"
#' author: "Anita Wang"
#' date: "10.12.21"
#' --- 

#5. Creating Scatter Plots 
#-----
#Install ggplot2
#install.packages("ggplot2")
#-----
#Start with a scatterplot
#Before we can use ggplot, we need to load it up
library(ggplot2)

#Every ggplot has a data + aesthetics + geometry layers -- specify the dataset + aesthetic mappings + geom layer
ggplot(data=cars) +
  aes(x=speed, y=dist) + 
  geom_point() +
  geom_smooth()

#Change to a linear model
p <- ggplot(data=cars) +
  aes(x=speed, y=dist) + 
  geom_point() +
  geom_smooth(method="lm") +
  theme_bw()

p + labs(title="My Nice Plot",
            x="Speed (MPH)",
            y="Stopping distance (ft)",
            subtitle="Speed and Stopping Distance of Cars",
            caption="Dataset: cars")

#Base graphics is shorter 
plot(cars)

#Adding more plot aesthetics through aes()
#Plotting a more relevant data set(results of a differential expression analysis where a new anti-viral drug is being tested)
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)

#Display top portion of data set
head(genes)

#Q: How many genes in data set?
nrow(genes)

#Q: What are the column names?
colnames(genes)

#Q: How many columns are there? 
ncol(genes)

#Q: How to access "state" column --  How many up-regulated genes are there?
table(genes$State)

#Q: What fraction of total genes is up-regulated in this dataset? 
table(genes$State) / nrow(genes)

#Q: Round answer 
round(table(genes$State) / nrow(genes))

#Q: Convert to percentage and round answer to 2 sig figs 
round(table(genes$State) / nrow(genes)*100,2)

#---------------
#Q5 last pt: Complete the code
library(ggplot2)
ggplot(genes) +
  aes(x=Condition1, y=Condition2) +
  geom_point()

# Color code plot by State 
p <- ggplot(genes) + 
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point()
p

#Change default colors 
p + scale_colour_manual(values=c("blue","gray","red"))

#Q: Add some plot annotations to the p object with the labs() function 
p + scale_colour_manual(values=c("blue","gray","red")) + 
  labs(title="Gene Expression Changes Upon Drug Treatment",
         x="Control(no drug)",
         y="Drug Treatement")

#Q: OPTIONAL: Going Further 

         
