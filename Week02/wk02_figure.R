#Week02 Figure

#Set values
x <- 1:50

#Plot x
plot(x, sin(x))

#Graph x
plot(x, sin(x), typ="l")

#Change graph color to blue
plot(x, sin(x), typ="l", col="blue")

#Make graph thicker 
plot(x, sin(x), typ="l", col="blue", lwd=5)

#Add label for x-axis
plot(x, sin(x), typ="l", col="blue", lwd=5, xlab="My values")


