/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyectocompiladores;

import java.util.ArrayList;
import java.util.Scanner;

public class TableQuad {

    ArrayList<TableRowQuad> rows = new ArrayList();

    

    //ArrayList<TableRowQuad> headerRows = new ArrayList():
    //int msgcount = 0;

    public TableQuad(){
        
    }

    public void addRow(TableRowQuad new_row) {
        rows.add(new_row);
    }

    public void addRow(String op, String arg) {
        rows.add(new TableRowQuad(op, arg, "", ""));
    }

    public void addRow(String op, String arg, String res) {
        rows.add(new TableRowQuad(op, arg, "", res));
    }

    public void addRow(String op, String arg1, String arg2, String res) {
        rows.add(new TableRowQuad(op, arg1, arg2, res));
    }

    public ArrayList<TableRowQuad> getRows() {
        return rows;
    }

    public void printTable(){


        System.out.println("-------------------Tabla Cuadruplos--------------------");
        System.out.println("OP  " + "   ARG1    " +  "  ARG2    " + "   RES ");
        for (TableRowQuad tableRowQuad : rows) {
            tableRowQuad.printRow();
        }
        System.out.println("-------------------------------------------------------");
    }

    public void resetearTabla(){
        rows.clear();
    }


    public void imprimirTablaCuadruplo(){
        System.out.println("Tabla de Cuadruplos: ");
        System.out.println("=============================="); 

        for(TableRowQuad cuad : rows){
            System.out.println(String.format(
                "| IND: %d | OP: %s | ARG1: %s | ARG2: %s | RES: %s |",
                rows.indexOf(cuad) + 1, cuad.op, cuad.arg1, cuad.arg2,
                cuad.res));
        }
        System.out.println("=============================="); 
    }

    
}
