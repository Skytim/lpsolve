#R solve
#https://gist.github.com/prasoonsharma/733497
# Load lpsolve library
# install.packages('lpSolve')
library('lpSolve')

# Read player data (name, position, price, points)
players <- read.csv("/home/big-data/examples/R/lpsolve/Fantasy-Football.csv", sep=",", header=TRUE)

# OBJECTIVE FUNCTION: Points of all players
f.obj <- players$Pts

# CONSTRAINTS:
num_goalkeepers <- 1
num_defenders <- 4
num_midfielders <- 3
num_strikers <- 3
max_team_cost <- 50
max_player_from_a_team <- 4   	# set "max_player_from_a_team <- 11" to ignore this constraint

# Create constraint vectors
defenders <- players$Pos=="DEF"
defenders[defenders==T] <- 1
defenders[defenders==F] <- 0

goalkeepers <- players$Pos=="GK"
goalkeepers[goalkeepers==T] <- 1
goalkeepers[goalkeepers==F] <- 0

midfielders <- players$Pos=="MID"
midfielders[midfielders==T] <- 1
midfielders[midfielders==F] <- 0

strikers <- players$Pos=="STR"
strikers[strikers==T] <- 1
strikers[strikers==F] <- 0

# constraint for max # players from a team
clubs <- sort(unique(players$Club))

team_constraint_vector <- c()
team_constraint_dir <- c()
team_constraint_rhs <- c()

for (i in 1:length(clubs)){
  temp <- players$Club==as.character(clubs[i])
  temp[temp==
  T] <- 1
  temp[temp==F] <- 0
  
  team_constraint_vector <- c(team_constraint_vector, temp)
  team_constraint_dir <- c(team_constraint_dir, "<=")
  team_constraint_rhs <- c(team_constraint_rhs, max_player_from_a_team)
}

f.con <- matrix (c(goalkeepers, defenders, midfielders, strikers, players$Price, team_constraint_vector), nrow=(5+length(clubs)), byrow=TRUE)
f.dir <- c("=", "=", "=", "=", "<=", team_constraint_dir)
f.rhs <- c(num_goalkeepers, num_defenders, num_midfielders, num_strikers, max_team_cost, team_constraint_rhs)

x <- lp ("max", f.obj, f.con, f.dir, f.rhs, all.bin=TRUE)
x
x$solution
players[which(x$solution==1),]