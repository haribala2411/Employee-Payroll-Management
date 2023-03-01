#!/bin/bash
echo ""
str1="ADD SALARY DETAILS OF A NEW EMPLOYEE"
len1=${#str1}
str2="SHOW SALARY DETAILS OF AN EMPLOYEE"
len2=${#str2}
str3="UPDATE SALARY DETAILS FOR AN EMPLOYEE"
len3=${#str3}
str4="EXIT"
len=0
ma=`echo 1000 | bc -l`
busfee=`echo 150 | bc -l`
cant=`echo 300 |bc -l`
while [ $len -ne 4 ]
do
choice=$(zenity --list  --title "EMPLOYEE PAYROLL MANAGEMENT" --radiolist  --column " " --column="OPTION" 1 "ADD SALARY DETAILS OF A NEW EMPLOYEE" 2 "SHOW SALARY DETAILS OF AN EMPLOYEE" 3 "UPDATE SALARY DETAILS FOR AN EMPLOYEE" 4 "EXIT" --width=600 --height=300)
len=${#choice}
if [ $len = $len1 ]
then
echo ""
echo -n "Employee No : "
read num
echo -n "Name        : "
read nam
echo -n "Department  : "
read dep
echo -n "Occupation  : "
read job
echo -n "Basic Salary: "
read bs
echo "Employee salary details are added...!"
hra=`echo 0.1 \* $bs | bc -l`
ca=`echo 0.033 \* $bs | bc -l`
ea=`echo 0.025 \* $bs | bc -l`
pf=`echo 0.07 \* $bs | bc -l`
credit=`echo 0.07 \* $bs | bc -l`
earn=`echo $bs + $hra + $ea + $ma + $ca | bc -l`
ded=`echo $pf + $credit + $busfee + $cant | bc -l`
net=`echo $earn - $ded | bc -l`
sudo mysql --login-path=sql sample<<end
insert into employee_salary_detail values($num, '$nam', '$dep', '$job', $hra, $ca, $ea, $earn, $pf, $credit, $ded, $net, $bs)
end
elif [ $len = $len2 ]
then
echo ""
id=$(zenity --entry --title "EMPLOYEE ID" --width=600 --height=300)
empname=`sudo mysql --login-path=sql -s -N sample<<end
select emp_name from employee_salary_detail where emp_idno = $id;
end`
if [ $empname ]
then
echo "----------------------MONTHLY PAYSLIP------------------------"
name=`sudo mysql --login-path=sql -s -N sample<<end
select emp_name from employee_salary_detail where emp_idno = $id;
end`
echo "Employee ID         : "$id
echo "Employee Name       : "$name
dept=`sudo mysql --login-path=sql -s -N sample<<end
select emp_dept from employee_salary_detail where emp_idno = $id;
end`
occp=`sudo mysql --login-path=sql -s -N sample<<end
select emp_occp from employee_salary_detail where emp_idno = $id;
end`
echo "Employee Department : "$dept
echo "Employee Occupation : "$occp
bs=`sudo mysql --login-path=sql -s -N sample<<end
select basic_salary from employee_salary_detail where emp_idno = $id;
end`
hra=`sudo mysql --login-path=sql -s -N sample<<end
select hra from employee_salary_detail where emp_idno = $id;
end`
ca=`sudo mysql --login-path=sql -s -N sample<<end
select ca from employee_salary_detail where emp_idno = $id;
end`
ea=`sudo mysql --login-path=sql -s -N sample<<end
select ea from employee_salary_detail where emp_idno = $id;
end`
pf=`sudo mysql --login-path=sql -s -N sample<<end
select pf from employee_salary_detail where emp_idno = $id;
end`
credit=`sudo mysql --login-path=sql -s -N sample<<end
select credit from employee_salary_detail where emp_idno = $id;
end`
earn=`sudo mysql --login-path=sql -s -N sample<<end
select gross_salary from employee_salary_detail where emp_idno = $id;
end`
ded=`sudo mysql --login-path=sql -s -N sample<<end
select deduction from employee_salary_detail where emp_idno = $id;
end`
net=`sudo mysql --login-path=sql -s -N sample<<end
select net_salary from employee_salary_detail where emp_idno = $id;
end`
echo "+--------------------------------+--------------------------+"
echo "|          Earnings              |         Deduction        |"
echo "+--------------------------------+--------------------------+"
printf "|Basic Salary         : %.2f |PF contribution : %.2f |\n" $bs $pf
printf "|House Rent Allowance :  %.2f |Bus Recovery    :  %.2f |\n" $hra $busfee
printf "|Conveyance Allowance :  %.2f |Canteen         :  %.2f |\n" $ca $cant
printf "|Education Allowance  :  %.2f |Credit society  : %.2f |\n" $ea $credit
printf "|Medical Allowance    :  %.2f |                          |\n" $ma
echo "+--------------------------------+--------------------------+"
printf "Total                   %.2f  Total             %.2f  \n\n" $earn $ded
printf "                                      Net Salary = %.2f\n" $net
echo ""
else
echo ""
zenity --info --text="THERE IS NO DATA FOR THE EMPLOYEE ID $num" --width=300
fi
elif [ $len = $len3 ]
then
echo ""
id1=$(zenity --entry --title "EMPLOYEE ID" --width=600 --height=300)
empname=`sudo mysql --login-path=sql -s -N sample<<end
select emp_name from employee_salary_detail where emp_idno = $id1;
end`
if [ $empname ]
then
echo -n "New Salary: "
read ns
hra1=`echo 0.1 \* $ns | bc -l`
ca1=`echo 0.033 \* $ns | bc -l`
ea1=`echo 0.025 \* $ns | bc -l`
pf1=`echo 0.07 \* $ns | bc -l`
credit1=`echo 0.07 \* $ns | bc -l`
earn1=`echo $ns + $hra1 + $ea1 + $ma + $ca1 | bc -l`
ded1=`echo $pf1 + $credit1 + $busfee + $cant | bc -l`
net1=`echo $earn1 - $ded1 | bc -l`
sudo mysql --login-path=sql -s -N sample<<end
update employee_salary_detail set hra=$hra1, ca=$ca1, ea=$ea1, gross_salary=$earn1, pf=$pf1, credit=$credit1, deduction=$ded1, net_salary=$net1, basic_salary=$ns where emp_idno=$id1;
end
echo "Employee salary details are updated...!"
else
echo ""
zenity --info --text="THERE IS NO DATA FOR THE EMPLOYEE ID $num" --width=300
fi
fi
done
echo ""
