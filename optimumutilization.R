#範例：
#某工廠耗用三種資源 (R1=人工，R2=設備 A，R3=設備 B)，可生產兩種產品 (P1，P2)：
#產品 P1 可由兩種製程 (D11, D12) 生產
#產品 P2 可由兩種製程 (D21, D22) 生產
#製程 D11 分別耗用資源 (R1=1.0，R2=8，R3=3)，但可獲利  800。
#製程 D12 分別耗用資源 (R1=1.5，R2=4，R3=2)，但可獲利 1200。
#製程 D21 分別耗用資源 (R1=1.0，R2=8，R3=3)，但可獲利  600。
#製程 D22 分別耗用資源 (R1=1.5，R2=4，R3=9)，但可獲利  700。
#人工   最大耗用量   80 小時
#設備 A 最大耗用量  150 小時
#設備 B 最大耗用量  130 小時
#問題：
	#1	求算工廠產品每週最多可獲利之金額。
	#2	求算工廠獲利最大之產品生產數量組合。
#解答輸出：
#          作業1  作業2  作業3  作業4         
#Maximize    800   1200    600    700         
#資源1         1    1.5      1    1.5  <=   80
#資源2         8      4      5      4  <=  150
#資源3         3      2     10      9  <=  130
#Kind        Std    Std    Std    Std         
#Type        Int    Int    Int    Int         
#Upper       Inf    Inf    Inf    Inf         
#Lower         0      0      0      0         
#            獲利=44400
#            作業(1)= 0
#            作業(2)=37
#            作業(3)= 0
#            作業(4)= 0
#install.packages("lpSolveAPI")
library(lpSolveAPI)
# 作業數
lprec <- make.lp(0, 4)

# 求最大值
lp.control(lprec, sense='max')

# 目標係數
set.objfn(lprec, c(800, 1200, 600, 700))

# 資源限制條件
add.constraint(lprec, c(1, 1.5, 1, 1.5), "<=", 80)
add.constraint(lprec, c(8, 4, 5, 4), "<=", 150)
add.constraint(lprec, c(3, 2, 10, 9), "<=", 130)

# 作業組合為正整數
set.bounds(lprec, lower = c(0, 0, 0, 0), columns = c(1, 2, 3, 4))
set.type(lprec, c(1, 2, 3, 4), "integer")

# 線性規劃表格-列/行-變數
dimnames(lprec) <- list(c("資源1", "資源2", "資源3"), 
                        c("作業1", "作業2", "作業3", "作業4"))

# 解算
solve(lprec)

# 輸出線性規劃表格
lprec  

# 解答
Ans.Optimization <- get.objective(lprec)
Ans.Varibles <- get.variables(lprec)

# 輸出最大值
print(sprintf("獲利=%d", Ans.Optimization))

# 輸出最大值下作業組合
for (i in seq(1:4)) {
  print(sprintf("作業(%d) 生產數=%2d", i, Ans.Varibles[i]))
}
