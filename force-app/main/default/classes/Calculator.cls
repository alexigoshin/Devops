/***********************************************************************************
 * Version      Date      Name         Description
 * ==================================================================================
 * V1.0       15/04/25   A.Igoshin    Add Method implemented
 * 
 ***********************************************************************************/
public with sharing class Calculator {
    public Calculator() {

    }
    public Integer add(Integer a, Integer b){
        return a+b;
    }
    public Integer sub(Integer a, Integer b){
        return a-b;
    }
    public Integer mul(Integer a, Integer b){
        return a*b;
    }
    public Integer div(Integer a, Integer b){
        return a/b;
    }    
}