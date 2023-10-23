<?php

// PROBLEM : ALL THE COURSES INTAKE ARE GETTING REDUCED BY ONE BUT ONLY ONE RECORD IS BEING INSERTED IN THE ALLOTMENT TABLE 

include_once 'database connectivity.php';

$query="SELECT * FROM CHOICES 
        WHERE 1 
        ORDER BY CPI DESC,TIMESTAMP";

$result = mysqli_query($db, $query);  //variable of the connection and the variable in which the query has been passed.


while($row=mysqli_fetch_array($result))  //an associative array is created and it fetches one record at a time.
{
        $row1 = $row["NAME"];
        $row2 = $row["URN"];
        $row3 = $row["BRANCH"];
        $row4= $row["CHOICE_1"];
        $row5= $row["CHOICE_2"];
        $row6= $row["CHOICE_3"];
        $allocation ="no";



        $s1="SELECT INTAKE FROM COURSES WHERE COURSE = '$row4'"; 
        /* variable to store the query which states that to select the 
        intake from courses where the course is $row4 which means the 
        course of the selected column.*/


        $res=mysqli_query($db,$s1);  //variable of the connection and the variable in which the query has been passed.


        while($new=mysqli_fetch_array($res))
        /*the intake of the column $row4 is selected and the records come one at a time*/

        {       
                          

                    $resv=$new['INTAKE'];   //THE INTAKE OF WHOLE COLUMN 1 comes in resv
                    
                    if($resv>0)
                    {   
                    
                    $db->query("INSERT INTO ALLOTMENT VALUES ('$row1', '$row2', '$row3', '1', '$row4')");  //name is also inserted into the database 
                    //only one record is being inserted but all records are being updated
                    
                    $s2="UPDATE COURSES 
                        SET INTAKE=INTAKE-1
                        where course = '$row4'";
                        $res1=mysqli_query($db,$s2); 
                        //$allocation="yes";
                        break;
                        
                    }
                    else goto ch2;
                

                    
        //*****************************************************************************
        
                    
                 ch2:
                        $s3="SELECT INTAKE FROM COURSES WHERE COURSE = '$row5'"; 
                    
                        $res1=mysqli_query($db,$s3);  //variable of the connection and the variable in which the query has been passed.


                    while($new1=mysqli_fetch_array($res1))
                    

                    {  
                    
                    $resv1=$new1['INTAKE'];   //THE INTAKE OF WHOLE COLUMN 1 comes in resv
                    

                    if($resv1>0)
                    {   
                    
                        $db->query("INSERT INTO ALLOTMENT VALUES ('$row1', '$row2', '$row3', '2', '$row5')");  //name is also inserted into the database 
                    //only one record is being inserted but all records are being updated
                    
                    $s4="UPDATE COURSES 
                        SET INTAKE=INTAKE-1
                        where course = '$row5'";
                        $res2=mysqli_query($db,$s4); 
                        // $allocation="yes";
                        break;
                    }
                    
                    else goto ch3;
                    //*****************************************************************************
                    
    

                    ch3:
                        $s5="SELECT INTAKE FROM COURSES WHERE COURSE = '$row6'"; 
                    
                        $res2=mysqli_query($db,$s5);  //variable of the connection and the variable in which the query has been passed.


                    while($new2=mysqli_fetch_array($res2))
                    

                    {  
                    
                    $resv2=$new2['INTAKE'];   //THE INTAKE OF WHOLE COLUMN 1 comes in resv
                    

                    if($resv2>0)
                    {   
                    
                        $db->query("INSERT INTO ALLOTMENT VALUES ('$row1', '$row2', '$row3', '3', '$row6')");  //name is also inserted into the database 
                    //only one record is being inserted but all records are being updated
                    
                    $s6="UPDATE COURSES 
                        SET INTAKE=INTAKE-1
                        where course = '$row6'";
                        $res3=mysqli_query($db,$s6); 
                        // $allocation="yes";
                        break;
                    }

                    else goto ua;

                    ua: 
                         $db->query("INSERT INTO unalloted VALUES ('$row1', '$row2', '$row3', 'NOT ALLOCATED')");

                    //*****************************************************************************
                    }
                }
            }

 }
 echo "ALLOTMENT DONE";


?>