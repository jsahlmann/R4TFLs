library(tidyverse)
library(ggplot2)
# ------------------------------------------------------------------------------
# From the developer of ggplot
# https://ggplot2-book.org/

# From the same author 
# https://r4ds.had.co.nz/index.html

# Beispielkapitel String-Handling
# https://www.gastonsanchez.com/r4strings/

# Diverse Quellen
# Paketbeschreibung: https://ggplot2.tidyverse.org/index.html
# Cheatsheet: https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf
# Grafikgalerie: https://r-graph-gallery.com/
# Top 50: http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html


# ------------------------------------------------------------------------------
# https://patorjk.com/software/taag/#p=display&f=Standard&t=Scatterplot
# ------------------------------------------------------------------------------
"#######################################################
#  ____            _   _                  _       _    #
# / ___|  ___ __ _| |_| |_ ___ _ __ _ __ | | ___ | |_  #
# \___ \ / __/ _` | __| __/ _ \ '__| '_ \| |/ _ \| __| #
#  ___) | (_| (_| | |_| ||  __/ |  | |_) | | (_) | |_  #
# |____/ \___\__,_|\__|\__\___|_|  | .__/|_|\___/ \__| #
#                                  |_|                 #
#######################################################"

# Basic scatterplot
head(iris)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point()

# Mit Regressionsgerade
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# Berechnung der Regressionsgeraden
lmf <- lm(Sepal.Width ~ Sepal.Length, data = iris)
lmf

# Hartkodierte Parameter
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() + 
  geom_smooth(method = "lm") + 
  geom_abline(aes(intercept=3.41895, slope=-0.06188), color = "grey") +
  xlim(c(0, 8)) +
  ylim(c(0, 5))

# Zugriff auf Parameter
lmf$coefficients

# Zuweisung zu Variablen
b0 <- lmf$coefficients[1]
b1 <- lmf$coefficients[2]

# Parameter aus Variablen außerhalb des Datensatzes für den Plot
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() + 
  geom_smooth(method = "lm") + 
  geom_abline(aes(intercept = b0, slope = b1), color = "grey") +
  xlim(c(0, 8)) +
  ylim(c(0, 5))

# Plot gruppieren
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) + 
  geom_point()

# Regressionsgerade per Gruppe
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# ------------------------------------------------------------------------------
# Basic scatterplot mit Größenajdustierung
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Scatterplot
data("midwest", package = "ggplot2")
head(midwest)

gg <- ggplot(midwest, aes(x = area, y = poptotal)) + 
  geom_point(aes(col = state, size = popdensity)) + 
  geom_smooth(method = "loess", se = F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) + 
  labs(subtitle = "Area Vs Population", 
       y = "Population", 
       x = "Area", 
       title = "Scatterplot", size = "Density", col = "State",
       caption = "Source: midwest")

plot(gg)

# ------------------------------------------------------------------------------
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Jitter%20Plot
data(mpg, package = "ggplot2")
head(mpg)
# disp = Hubraum
theme_set(theme_bw())


gg <- ggplot(mpg, aes(cty, hwy))

# Scatterplot mit überlappenden Punkten
gg + geom_point() + 
  geom_smooth(method="lm", se=F) +
  labs(subtitle="mpg: city vs highway mileage", 
       y="hwy", 
       x="cty", 
       title="Scatterplot with overlapping points", 
       caption="Source: midwest")

# Scatterplot mit gestreuten Punkten
gg <- ggplot(mpg, aes(cty, hwy))
gg + geom_jitter(width = .5, size=1) +
  labs(subtitle = "mpg: city vs highway mileage", 
       y = "hwy", 
       x = "cty", 
       title = "Scatterplot with jittered Points")

# ------------------------------------------------------------------------------
# https://patorjk.com/software/taag/#p=display&f=Standard&t=Histogramm
# ------------------------------------------------------------------------------
"##############################################################
#  _   _ _     _                                              #
# | | | (_)___| |_ ___   __ _ _ __ __ _ _ __ ___  _ __ ___    #
# | |_| | / __| __/ _ \ / _` | '__/ _` | '_ ` _ \| '_ ` _ \   #
# |  _  | \__ \ || (_) | (_| | | | (_| | | | | | | | | | | |  #
# |_| |_|_|___/\__\___/ \__, |_|  \__,_|_| |_| |_|_| |_| |_|  #
#                       |___/                                 #
##############################################################"
# Basic histogram
theme_set(theme_classic())

# Histogram on a Continuous (Numeric) Variable
gg <- ggplot(mpg, aes(displ)) + scale_fill_brewer(palette = "Spectral")

# Natives Histogramm ohne Vorgaben
gg + geom_histogram()

# Histogramm mit vorgegebener Breite der Behälter
gg + geom_histogram(aes(fill = class), 
                   binwidth  =  .1, 
                   col = "black", 
                   size = .1) + 
  labs(title = "Histogramm mit vorgegebener Breite", 
       subtitle = "Hubraum vs. Klasse")  

# Histogramm mit vorgegebener Zahl der Behälter
gg + geom_histogram(aes(fill = class), 
                   bins = 5, 
                   col = "black", 
                   size = .1) + 
  labs(title = "Histogramm mit vorgegebener Zahl der Behälter", 
       subtitle = "Hubraum vs. Klasse") 



# Verschiedene Farbvarianten gemäß Hilfetext im Paket
# Diverging:
# BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral
# Qualitative:
# Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3
# Sequential:
# Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, 
# Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
gg + scale_fill_brewer(palette = "Oranges") + 
  geom_histogram(aes(fill = class), 
                    bins = 5, 
                    col = "black", 
                    size = .1) +  
  labs(title = "Histogramm mit vorgegebener Zahl der Behälter", 
       subtitle = "Hubraum vs. Klasse", fill = "Class") 


# Verschiedene Kombinationen aller Parameter als Themen
# https://ggplot2.tidyverse.org/reference/ggtheme.html
theme_set(theme_void())
theme_get()

theme_test <- gg + scale_fill_brewer(palette = "Oranges") + 
  geom_histogram(aes(fill = class), 
                 bins = 5, 
                 col = "black", 
                 size = .1) +  
  labs(title = "Histogramm mit vorgegebener Zahl der Behälter", 
       subtitle = "Hubraum vs. Klasse", fill = "Class") 

theme_test

theme_set(theme_minimal())
theme_test

theme_set(theme_bw())
theme_test

theme_set(theme_light())
theme_test

theme_set(theme_dark())
theme_test

theme_set(theme_classic())





# ------------------------------------------------------------------------------
# Basic Pie Chart
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Pie%20Chart
# ------------------------------------------------------------------------------
"##############################################
#  ____  _         ____ _                _    #
# |  _ \(_) ___   / ___| |__   __ _ _ __| |_  #
# | |_) | |/ _ \ | |   | '_ \ / _` | '__| __| #
# |  __/| |  __/ | |___| | | | (_| | |  | |_  #
# |_|   |_|\___|  \____|_| |_|\__,_|_|   \__| #
#                                             #
##############################################"
# ------------------------------------------------------------------------------
# Berechnung der Häufigkeiten als Grundlage für die Grafik
df <- as.data.frame(table(mpg$class))
colnames(df) <- c("class", "freq")
pie <- ggplot(df, aes(x = "", y=freq, fill = factor(class))) + 
  geom_bar(width = 1, stat = "identity") +
  theme(axis.line = element_blank(), 
        plot.title = element_text(hjust=0.5)) + 
  labs(fill = "Class", 
       x = NULL, 
       y = NULL, 
       title = "Pie Chart of class", 
       caption = "Source: mpg")
pie
# Ausgabe mit Polarkoordinaten macht den Kuchen rund
pie + coord_polar(theta = "y", start = 0, direction = 1)

# Wechsel der Farbpalette
pie + coord_polar(theta = "y", start = 0, direction = 1) +
  scale_fill_brewer(palette = "Oranges")

# Manuelle Farbpalette durch vordefinierte Farbwerte
cols <- c("2seater" = "red", "compact" = "blue", "midsize" = "darkgreen", 
          "minivan" = "orange", "pickup" =  "purple", "subcompact" = "yellow", 
          "suv" = "lightgreen")
pie + coord_polar(theta = "y", start = 0, direction = 1) +
  scale_colour_manual(values = cols, aesthetics = c("fill"))

# Manuelle Farbpalette durch RGB-Werte
# https://werner-zenk.de/tools/farbverlauf.php#form
cols <- c("2seater" = "#00ffff", "compact" = "#00e9ff", "midsize" = "#00d4ff", 
          "minivan" = "#00beff", "pickup" =  "#00a9ff", "subcompact" = "#0093ff", 
          "suv" = "#007eff")
pie + coord_polar(theta = "y", start = 0, direction = 1) +
  scale_colour_manual(values = cols, aesthetics = c("fill"))




# ------------------------------------------------------------------------------
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Density%20Plot
# ------------------------------------------------------------------------------
"#########################################################
#  ____                 _ _                 _       _    #
# |  _ \  ___ _ __  ___(_) |_ _   _   _ __ | | ___ | |_  #
# | | | |/ _ \ '_ \/ __| | __| | | | | '_ \| |/ _ \| __| #
# | |_| |  __/ | | \__ \ | |_| |_| | | |_) | | (_) | |_  #
# |____/ \___|_| |_|___/_|\__|\__, | | .__/|_|\___/ \__| #
#                             |___/  |_|                 #
#########################################################"

# Basic density plot

theme_set(theme_classic())
gg <- ggplot(mpg, aes(cty))
gg + geom_density(aes(fill=factor(cyl)), alpha=0.8) + 
   labs(title="Density plot", 
       subtitle="Stadtmeilen pro Galon gruppiert nach Zahl der Zylinder",
       caption="Source: mpg",
       x="Stadtmeilen pro Galon",
       fill="# Zylinder")

# ------------------------------------------------------------------------------
# http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Box%20Plot
# ------------------------------------------------------------------------------
"#########################################
#   ____                    _       _    #
#  | __ )  _____  __  _ __ | | ___ | |_  #
#  |  _ \ / _ \ \/ / | '_ \| |/ _ \| __| #
#  | |_) | (_) >  <  | |_) | | (_) | |_  #
#  |____/ \___/_/\_\ | .__/|_|\___/ \__| #
#                    |_|                 #
#########################################"

# Basic box plot

gg <- ggplot(mpg, aes(class, cty))
gg + geom_boxplot(varwidth=T, fill="plum") + 
   labs(title="Box plot", 
        subtitle="Stadtmeilen pro Galon gruppiert nach Autoklasse",
        caption="Source: mpg",
        x="Autoklasse",
        y="Stadtmeilen pro Galon")

gg <- ggplot(mpg, aes(class, cty))
gg + geom_boxplot(aes(fill=factor(cyl))) + 
  labs(title="Box plot", 
       subtitle="Stadtmeilen pro Galon gruppiert nach Autoklasse",
       caption="Source: mpg",
       fill = "# Zylinder",
       x="Autoklasse",
       y="Stadtmeilen")

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Basic line plot
"############################################
#   _     _                    _       _    #
#  | |   (_)_ __   ___   _ __ | | ___ | |_  #
#  | |   | | '_ \ / _ \ | '_ \| |/ _ \| __| #
#  | |___| | | | |  __/ | |_) | | (_) | |_  #
#  |_____|_|_| |_|\___| | .__/|_|\___/ \__| #
#                       |_|                 #
############################################"

# Daten erzeugen
set.seed(123)
x <- 1:10
y <- cumsum(rnorm(10, 1, 1))
y2 <- cumsum(rnorm(10, 2, 0.5))
df <- data.frame(x, y, y2)

# Plot
ggplot(df, aes(x = x, y = y)) +
  geom_line()

# Plot
ggplot(df, aes(x = x, y = y)) +
  geom_line(color = "red") +
  geom_line(aes(y = y2), color = "green")

ggplot(df, aes(x = x, y = y)) +
  geom_line(color = "red") +
  geom_point() +
  geom_line(aes(y = y2), color = "green") +
  geom_point(aes(y = y2))


# Plot
ggplot(df, aes(x = x, y = y)) +
  geom_line( color="#69b3a2", size = 2, alpha = 0.9, linetype = 2) +
  ggtitle("Linienzug")



# ------------------------------------------------------------------------------
# Bubble plot

load(file = "data/gapminder.RData")
data <- df %>% filter(year=="2007") %>% dplyr::select(-year)

# Most basic bubble plot
ggplot(data, aes(x=gdpPercap, y=lifeExp, size = pop)) +
  geom_point(alpha=0.7)


# Most basic bubble plot
data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, size = pop)) +
  geom_point(alpha=0.5) +
  scale_size(range = c(.1, 24), name="Population (M)")

# Most basic bubble plot
data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop, color=continent)) +
  geom_point(alpha=0.5) +
  scale_size(range = c(.1, 24), name="Population (M)")


# Most basic bubble plot
data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop, fill=continent)) +
  geom_point(alpha=0.5, shape=21, color="black") +
  scale_size(range = c(.1, 24), name="Population (M)") +
  theme(legend.position="bottom") +
  ylab("Life Expectancy") +
  xlab("Gdp per Capita") 


