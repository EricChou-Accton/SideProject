# coding=utf-8
a = int(input("請輸入帳單金額為?"))
b = int(input("你想要給多少小費?"))
c = int(input("共有多少人用餐?"))
d = input("服務費比例(%)")
e = "1."
f = float(e+d)
print ("每個人應支付", float(a+b)*f/c)