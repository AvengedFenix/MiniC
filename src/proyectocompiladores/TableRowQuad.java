/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyectocompiladores;

import java.util.Scanner;

public class TableRowQuad {

    public String op;
    public String arg1;
    public String arg2;
    public String res;

    public TableRowQuad(String op, String arg1) {
        this.op = op;
        this.arg1 = arg1;
    }

    public TableRowQuad(String op, String arg1, String res) {
        this.op = op;
        this.arg1 = arg1;
        this.res = res;
    }

    public TableRowQuad(String op, String arg1, String arg2, String res) {
        this.op = op;
        this.arg1 = arg1;
        this.arg2 = arg2;
        this.res = res;
    }

    public void printRow(){
        String ret = op + "       " + arg1 + "        " + arg2 + "        " + res;
        System.out.println(ret);
    }

    public String getArg1(){
        return arg1;
    }

    public String getArg2(){
        return arg2;
    }

    public String getOp(){
        return op;
    }

    public String getRes(){
        return res;
    }
}
