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
#Visualizing the gapminder dataset
#install.packages("gapminder")
library(gapminder)

#install dplyr package to focus in on a single year in gapminder dataset
#install.packages("dplyr")
library(dplyr)
gapminder_2007 <-gapminder %>% filter(year==2007)
#Q: Produce first basica scatter plot of gapminder_2007 dataset
library(ggplot2)
ggplot(gapminder_2007) + 
  aes(x=gdpPercap, y=lifeExp) + 
  geom_point()
#Add alpha argument to make points slightly transparent 
ggplot(gapminder_2007) + 
  aes(x=gdpPercap, y=lifeExp) + 
  geom_point(alpha=0.5)
#Adding more variables to aes() 
#Coloring scheme based on the categorical data type of the variable continent
ggplot(gapminder_2007)+
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop)+
  geom_point(alpha=0.5)
#Coloring scheme based on the numeric variable population pop
ggplot(gapminder_2007)+
  aes(x=gdpPercap, y=lifeExp, color=pop)+
  geom_point(alpha=0.5)      
#Adjusting point size -- binned by default
ggplot(gapminder_2007)+
  aes(x=gdpPercap, y=lifeExp, size=pop)+
  geom_point(alpha=0.5)
#Adjusting point size -- to reflect actual population differences, we adjust the point's max_size, results in bigger point sizes 
ggplot(gapminder_2007)+
  geom_point(aes(x=gdpPercap, y=lifeExp, size=pop), alpha=0.5)+
  scale_size_area(max_size=10)
#Producing gapminder scatter plot for the year 1957
library(dplyr)
gapminder_1957 <-gapminder %>% filter(year==1957)
library(ggplot2)
ggplot(gapminder_1957)+
  geom_point(aes(x=gdpPercap, y=lifeExp, color=continent,size=pop), alpha=0.7)+
  scale_size_area(max_size=15)
#Q: Visualizing years 1957 + 2007 together 
library(dplyr)
gapminder_both <-gapminder %>% filter(year==1957 | year==2007)
library(ggplot2)
ggplot(gapminder_both)+
  geom_point(aes(x=gdpPercap, y=lifeExp, color=continent,size=pop), alpha=0.7)+
  scale_size_area(max_size=15)+
  facet_wrap(~year)
#7.OPTIONAL: Bar Charts 
#Intro
library(dplyr)
gapminder_top5 <- gapminder %>%
  filter(year==2007) %>%
  arrange(desc(pop))%>%
  top_n(5,pop)
gapminder_top5
#Creating a simple bar chart
library(ggplot2)
ggplot(gapminder_top5)+
  geom_col(aes(x=country,y=pop))
#Plot life expectancy by country
ggplot(gapminder_top5)+
  geom_col(aes(x=country, y=lifeExp))
#Filling bars with color -- 
#with categorical variable ("continent") == clear color scheme
ggplot(gapminder_top5)+
  geom_col(aes(x=country,y=pop,fill=continent))
#Filling bars with color -- 
#with numberic variable (lifeExp) == continuous color scheme
#Numeric variables can be used to fill bars!
ggplot(gapminder_top5)+
  geom_col(aes(x=country,y=pop,fill=lifeExp))
#Plot population size by country 
ggplot(gapminder_top5)+
  geom_col(aes(x=country, y=pop,fill=gdpPercap))
#Changing the order of the bars
ggplot(gapminder_top5)+
  aes(x=reorder(country,-pop),y=pop,fill=gdpPercap)+
  geom_col()
#Fill by country
ggplot(gapminder_top5)+
  aes(x=reorder(country,-pop),y=pop,fill=country)+
  geom_col(col="gray30")+
  guides(fill=FALSE)
#Flipping bar charts
head(USArrests)
USArrests$State <- rownames(USArrests)
library(ggplot2)
ggplot(USArrests)+
  aes(x=reorder(State,Murder),y=Murder)+
  geom_col()+
  coord_flip()
#Flipped bar graph too crowded? -> Try alternative custom visualization
ggplot(USArrests)+
  aes(x=reorder(State,Murder),y=Murder)+
  geom_point()+
  geom_segment(aes(x=State,
                   xend=State,
                   y=0,
                   yend=Murder), color="blue")+
  coord_flip()
#8.ADVANCED: Plot Animation 
#Install gganimate and gifski
#install.packages("gganimate")
#install.packages("gifski")
library(gapminder)
library(gganimate)
#Setup a nice regular ggplot of the gapminder data
ggplot(gapminder, aes(gdpPercap, lifeExp, size=pop, color=country))+
  geom_point(alpha=0.7, show.legend=FALSE)+
  scale_color_manual(values=country_colors)+
  scale_size(range=c(2,12))+
  scale_x_log10()+
  #Facet (multiple graphs) by continent 
  facet_wrap(~continent)+
  #Using gganimate
  labs(title='Year:{frame_time}',x='GDP per capita',y='life expectancy')+
  transition_time(year)+
  shadow_wake(wake_length=0.1,alpha=FALSE)
#9.Combining plots 
#Install patchwork
#install.packages("patchwork")
library(patchwork)
library(ggplot2)
#Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg,disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear,disp,group=gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp,qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))
#Use patchwork to combine p1, p2, p3, p4
(p1|p2|p3)/
    p4


