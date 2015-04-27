#www.pershing.com.tw
#Tim_Tsai
#Minimum outsourcing project costing
#Scene
#We have three of the long-term third-party provider(W1, W2, W3) which all have same quality and ability :
#Part of outsourcing project has three subprojects (T1, T2, T3).
#W1 contract quotes 160,000 for T1,quotes 100,000 for T2,quotes 130,000 for T3.
#W2 contract quotes 220,000 for T1,quotes 180,000 for T2,quotes 230,000 for T3.
#W3 contract quotes 150,000 for T1,quotes 250,000 for T2,quotes 170,000 for T3.
#Problem:
#The minimum amount project outsourcing costs.
#Best third-party providers of outsourcing contract subproject portfolio.
library(lpSolveAPI)

# ??Limit the number of conditions, the benefits the number of variables
lprec <- make.lp(0, 9)

# Request maximum
lp.control(lprec, sense='min')

# Objective coefficient
set.objfn(lprec, c(16, 22, 15, 10, 18, 25,13, 23, 17))

# Resource constraints
add.constraint(lprec, c(1, 1, 1, 0, 0, 0, 0, 0, 0), "=", 1)
add.constraint(lprec, c(0, 0, 0, 1, 1, 1, 0, 0, 0), "=", 1)
add.constraint(lprec, c(0, 0, 0, 0, 0, 0, 1, 1, 1), "=", 1)
add.constraint(lprec, c(1, 0, 0, 1, 0, 0, 1, 0, 0), "=", 1)
add.constraint(lprec, c(0, 1, 0, 0, 1, 0, 0, 1, 0), "=", 1)
add.constraint(lprec, c(0, 0, 1, 0, 0, 1, 0, 0, 1), "=", 1)

lprec

# Variable is a positive integer
set.bounds(lprec, lower = c(0,0,0, 0,0,0, 0,0,0), columns = seq(1:9))
set.type(lprec, seq(1:9), "integer")

# Solution
solve(lprec)

# Output linear programming table
lprec  

# Answer
Ans.Optimization <- get.objective(lprec)
Ans.Varibles <- get.variables(lprec)

# The maximum 
print(sprintf("Minimum Cost=%d", Ans.Optimization))

# The maximum Task Combination
for (i in seq(1:9)) {
  if(Ans.Varibles[i]==1)
  print(sprintf("Third-party manufacturers(%d) Contracting subproject", i))
}
