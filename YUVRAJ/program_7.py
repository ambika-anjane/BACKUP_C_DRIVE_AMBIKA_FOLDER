employeenumber = int()
employeename = str()
basicsalary = int()
hra = int()
da = int()
ta = int()
pf = int()
ins = int()
grosssalary = int()
deductables = int()
netsalary = int()


print ("Enter Employee Number : ")
employeenumber = input()

print ("Enter Employee Name : ")
employeename = input()

print ("Enter Basic Salary : ")
basicsalary = input()

print ("Enter House Rent Allowance : ")
hra = input()

print ("Enter Dearness Allowance : ")
da = input()

print ("Enter Travel Allowance : ")
ta = input()

print ("Enter Providend Fund : ")
pf = input()

print ("Enter Insurance : ")
ins = input()


grosssalary = int(basicsalary) + int(hra) + int(da) + int(ta)

deductables = int(pf) + int(ins)

netsalary = int(grosssalary) - int(deductables);

print ("Employee Number : ", employeenumber)
print ("Employee Name : ", employeename)
print ("Basic Salary : ", basicsalary)
print ("House Rent Allowance : ", hra)
print ("Dearness Allowance : ", da)
print ("Travel Allowance : ", ta)
print ("Providend Fund : ", pf)
print ("Insurance : ", ins)
print ("Gross Salary : ", grosssalary)
print ("Total Deductables : ", deductables)
print ("Net Salary : ", netsalary)

