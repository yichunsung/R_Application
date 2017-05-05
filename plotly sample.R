library(plotly)

dt <- data.frame(
  x = 1:8,
  freq = c(120,130,140,150,160,170,170,180),
  earn = c(3,3,5,4,6,7,3,5) * 0.1
)

dt_earn_plotly <- plot_ly(data = dt, x=dt$x, y=dt$earn, type = "scatter", mode = "liners", name = "earn")
dt_freq_plotly <- plot_ly(data = dt, x=dt$x, y=dt$freq, type = "bar", name = "freq")
dt_plotly <- subplot(dt_earn_plotly, dt_freq_plotly,  nrows = 2, shareX = TRUE)

dt_plotly


