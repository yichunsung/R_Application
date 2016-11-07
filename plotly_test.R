library(plotly)

group <- c(rep("A", times = 4), rep("B", times = 3), rep("C", times = 5))
name <- c("Mike", "Jo", "Chris", "Zuni", "Bob", "Ape", "Geo", "Tek", "Fred", "Joy", "Ply", "Kou")
scores <- c(75, 50, 99, 82, 66, 77, 45, 36, 43, 66, 55, 90)

df <- data.frame(group, name, scores)

dfA <- subset(df, group=="A")
dfA_new <- data.frame(as.vector(dfA$group), as.vector(dfA$name), as.numeric(dfA$scores))
names(dfA_new)[1:3] <- c("group", "name", "scores")

dfB <- subset(df, group=="B")
dfB_new <- data.frame(as.vector(dfB$group), as.vector(dfB$name), as.numeric(dfB$scores))
names(dfB_new)[1:3] <- c("group", "name", "scores")

dfC <- subset(df, group=="C")
dfC_new <- data.frame(as.vector(dfC$group), as.vector(dfC$name), as.numeric(dfC$scores))
names(dfC_new)[1:3] <- c("group", "name", "scores")


plot_df <- plot_ly(dfA_new, x=dfA_new$name, y=dfA_new$scores, type = "scatter", mode="markers", name='A')%>%
  add_trace(x=dfB_new$name, y=dfB_new$scores, name='B')%>%
  add_trace(x=dfC_new$name, y=dfC_new$scores, name='C')
plot_df
