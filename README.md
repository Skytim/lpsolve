lpsolve
======================================
下面有關於線性規劃的R應用
經由簡化過後
可以當作參考

Minimum_outsourcing.R
--------------------------------------
		www.pershing.com.tw
		Tim_Tsai
		Minimum outsourcing project costing
		Scene
		We have three of the long-term third-party provider(W1, W2, W3) which all have same quality and ability :
		Part of outsourcing project has three subprojects (T1, T2, T3).
		W1 contract quotes 160,000 for T1,quotes 100,000 for T2,quotes 130,000 for T3.
		W2 contract quotes 220,000 for T1,quotes 180,000 for T2,quotes 230,000 for T3.
		W3 contract quotes 150,000 for T1,quotes 250,000 for T2,quotes 170,000 for T3.
		Problem:
		The minimum amount project outsourcing costs.
		Best third-party providers of outsourcing contract subproject portfolio.



Optimumutilization.R
--------------------------------------

某公司消耗三種不同單位資源 (R1=人工，R2=設備 A，R3=設備 B)，可生產兩種產品 (P1，P2)：
產品 P1 可由兩種製程 (D11, D12) 生產
產品 P2 可由兩種製程 (D21, D22) 生產
製程 D11 分別耗用資源 (R1=1.0，R2=8，R3=3)，但可獲利  800。
製程 D12 分別耗用資源 (R1=1.5，R2=4，R3=2)，但可獲利 1200。
製程 D21 分別耗用資源 (R1=1.0，R2=8，R3=3)，但可獲利  600。
製程 D22 分別耗用資源 (R1=1.5，R2=4，R3=9)，但可獲利  700。
人工   最大耗用量   80 小時
設備 A 最大耗用量  150 小時
設備 B 最大耗用量  130 小時
問題：
	1	求算工廠產品每週最多可獲利之金額。
	2	求算工廠獲利最大之產品生產數量組合。


解答輸出：
          作業1  作業2  作業3  作業4         
Maximize    800   1200    600    700         
資源1         1    1.5      1    1.5  <=   80
資源2         8      4      5      4  <=  150
資源3         3      2     10      9  <=  130
Kind        Std    Std    Std    Std         
Type        Int    Int    Int    Int         
Upper       Inf    Inf    Inf    Inf         
Lower         0      0      0      0 


獲利=44400
作業(1)= 0
作業(2)=37
作業(3)= 0
作業(4)= 0