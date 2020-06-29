/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyectocompiladores;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class FinalCode {

    private File file;
    private String mipsHeader = "";

    public FinalCode(File file) {
        this.file = file;
    }

    public void generate(TableQuad quad, Table table) throws FileNotFoundException, IOException {
        FileOutputStream fileOut = new FileOutputStream(file);
        fileOut.write(mipsHeader.getBytes());

        ArrayList<TableRowQuad> tr = quad.getRows();

        String toWrite;
        int paramCount = 0;
        int msgCount = 0;
        int fixedStack = 0;
        int tempCount = 0;

        fileOut.write(".data\n".getBytes());
        toWrite = ".text\n.globl main\n";
        fileOut.write(toWrite.getBytes());

        for (TableRowQuad row : tr) {
            toWrite = "";
            switch (row.op) {
                case "*":
                    if (toWrite.isEmpty()) {
                        toWrite = "mul ";
                    }
                case "/":
                    if (toWrite.isEmpty()) {
                        toWrite = "div ";
                    }
                case "+":
                    if (toWrite.isEmpty()) {
                        toWrite = "add ";
                    }
                case "-": {
                    if (toWrite.isEmpty()) {
                        toWrite = "sub ";
                    }
                    if (row.arg1.equals("t0")) {
                        row.arg1 = "$" + row.arg1;
                    }
                    if (row.res.equals("t0")) {
                        row.res = "$" + row.res;
                    }
                    toWrite += row.res + ", ";
                    TableRow search = table.search(row.arg1);
                    if (search != null) {
                        int offset = fixedStack - search.offset - Table.getTypeSize(search.type);
                        String load = "lw $t0, " + offset + "($fp)\n";
                        fileOut.write(load.getBytes());
                        toWrite += "$t0, ";
                    } else {
                        toWrite += row.arg1 + ", ";
                    }
                    toWrite += row.arg2 + "\n";
                    fileOut.write(toWrite.getBytes());
                    break;
                }
                case "=": {
                    if (row.arg1.equals("t0")) {
                        row.arg1 = "$" + row.arg1;
                    } else if (row.arg1.equals("RET")) {
                        row.arg1 = "$v0";
                    }
                    if (row.res.equals("t0")) {
                        row.res = "$" + row.res;
                        toWrite = "move " + row.res + ", " + row.arg1 + "\n";
                    } else {
                        TableRow search = table.search(row.res);
                        System.out.println(row.res);
                        int offset = fixedStack - search.offset - Table.getTypeSize(search.type);
                        toWrite = "sw " + row.arg1 + ", " + offset + "($fp)\n";
                    }
                    fileOut.write(toWrite.getBytes());
                    break;
                }
            }
        }
        fileOut.close();
    }
}
