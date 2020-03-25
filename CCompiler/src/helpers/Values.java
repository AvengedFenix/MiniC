/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package helpers;
import java.util.ArrayList;
import java.util.Scanner;

public class Values {
    public String tree;
    public ArrayList<String[]> list = new ArrayList<String[]>();

    public Values(String tree, ArrayList<String[]> list ) {
        this.tree = tree;
        this.list = new ArrayList<String[]>(list);
    }

    @Override
    public String toString() {
        return tree;
    }
    
}
