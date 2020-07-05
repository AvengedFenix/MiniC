/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyectocompiladores;

import java.util.ArrayList;
import java.util.Scanner;

public class TempsList {

    public ArrayList<String[]> tempsList = new ArrayList<String[]>();

    public TempsList() {
        for (int i = 0; i < 8; i++) {
            String[] newTemp = new String[2];
            newTemp[0] = "$t" + i;
            newTemp[1] = "";
            tempsList.add(newTemp);
        }
    }

    public String[] nextAvailable() {
        int tempNumber = 0;
        for (int i = 0; i < tempsList.size(); i++) {
            if (tempsList.get(i)[1].isEmpty()) {
                return tempsList.get(i);
            }
        }
        String[] error = new String[2];
        error[0] = "Error";
        return error;
    }

    public void fill(String toUpdate, String update) {
        for (int i = 0; i < tempsList.size(); i++) {
            if (tempsList.get(i)[0].equals(toUpdate)) {
                tempsList.get(i)[1] = update;
            }
        }
    }

    public void freeTemp(String toUpdate) {
        for (int i = 0; i < tempsList.size(); i++) {
            if (tempsList.get(i)[0].equals(toUpdate)) {
                tempsList.get(i)[1] = "";
            }
        }
    }

    public String search(String arg) {
        for (int i = 0; i < tempsList.size(); i++) {
            if (tempsList.get(i)[1].contains("_" + arg) || tempsList.get(i)[1].contains(arg)) {
                return tempsList.get(i)[0];
            }
        }
        return "";
    }

    @Override
    public String toString() {
        String table = "";
        for (int i = 0; i < tempsList.size(); i++) {
            table += i + "; " + "[0]: " + tempsList.get(i)[0] + " -> [1]: "
                    + tempsList.get(i)[1] + "\n";
        }
        return table;
    }

}
