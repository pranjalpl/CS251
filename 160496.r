#step1
data <- rexp(50000,0.2)
s <- data.frame(X = seq(1, 50000 , 1), Y = sort(data))
plot(s, main="Scatter Plot of Data",xlab="Data",ylab="Value")

#step2
dim(data) <- c(500,100)

#step3
x1 = density(data[1,])
y1 = ecdf(data[1,])
x2 = density(data[2,])
y2 = ecdf(data[2,])
x3 = density(data[3,])
y3 = ecdf(data[3,])
x4 = density(data[4,])
y4 = ecdf(data[4,])
x5 = density(data[5,])
y5 = ecdf(data[5,])

plot(x1,main = "PDF of first partition",xlab="X",ylab="PDF of X")
plot(y1,main = "CDF of first partition",xlab="X",ylab="CDF of X")
plot(x2,main = "PDF of second partition",xlab="X",ylab="PDF of X")
plot(y2,main = "CDF of second partition",xlab="X",ylab="CDF of X")
plot(x3,main = "PDF of third partition",xlab="X",ylab="PDF of X")
plot(y3,main = "CDF of third partition",xlab="X",ylab="CDF of X")
plot(x4,main = "PDF of fourth partition",xlab="X",ylab="PDF of X")
plot(y4,main = "CDF of fourth partition",xlab="X",ylab="CDF of X")
plot(x5,main = "PDF of fifth partition",xlab="X",ylab="PDF of X")
plot(y5,main = "CDF of fifth partition",xlab="X",ylab="CDF of X")

means <- c()
sds <- c()

for(i in 1:500){
	means[i] = mean(data[i,])
	sds[i] = sd(data[i,])
}


print(paste("First 5 Means"))
print(means[1:5])
print(paste("First 5 Standard Deviations"))
print(sds[1:5])

#step4
hist(means,xlab="Means")
x <- density(means)
plot(x,main="PDF of Means of Each Partition",xlab="X",ylab="PDF of X")
y <- ecdf(means)
plot(y,main="CDF of Means of Each Partition",xlab="X",ylab="CDF of X")

#step5
meanomean <- mean(means)
sdomeans <- sd(means)

#step6
print(paste("Mean of Data"))
print(mean(data))
print(paste("Mean of Means"))
print(meanomean)
print(paste("Standard Deviation of Data"))
print(sd(data))
print(paste("Standard Deviation of Means"))
print(sdomeans)