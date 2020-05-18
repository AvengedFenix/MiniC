/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package proyectocompiladores;
import java.util.ArrayList;
import java.util.Scanner;

public class Values {
    public String tree;
    public ArrayList<String[]> list = new ArrayList<String[]>();
    public boolean addReturn;
    public String message;

    public Values(String tree, ArrayList<String[]> list ) {
        this.tree = tree;
        this.list = new ArrayList<String[]>(list);
    }

    public Values(boolean addReturn, String message) {
        this.addReturn = addReturn;
        this.message = message;
    }

    public Values(boolean addReturn) {
        this.addReturn = addReturn;
    }
    
    

    @Override
    public String toString() {
        return tree;
    }
    
}
