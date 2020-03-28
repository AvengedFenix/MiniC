
package proyectocompiladores;

import proyectocompiladores.Values;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Objects;
import java_cup.runtime.Symbol;
import org.graphstream.graph.*;
import org.graphstream.graph.implementations.SingleGraph;

public class TreeNode {

    public ArrayList<String[]> graphList = new ArrayList<String[]>();
    Graph graph = new SingleGraph("AST");

    private TreeNode parent;
    private ArrayList<TreeNode> childs = new ArrayList();
    private Symbol value;

    public TreeNode(TreeNode copy) {
        parent = copy.parent;
        childs = copy.childs;
        value = copy.value;
    }

    public TreeNode(TreeNode parent, Symbol value) {
        this.parent = parent;
        this.value = value;
    }

    public TreeNode(TreeNode parent, String value) {
        this.parent = parent;
        this.value = new Symbol(-1, 0, 0, value);
    }

    public boolean addChild(TreeNode newChild) {
        newChild.parent = this;
        return childs.add(newChild);
    }

    public boolean addChild(Object value) {
        return childs.add(new TreeNode(this, (Symbol) value));
    }

    public void setParent(TreeNode parent) {
        this.parent = parent;
    }

    public void removeParent() {
        this.parent = null;
    }

    public TreeNode getParent() {
        return this.parent;
    }

    public Symbol getValue() {
        return this.value;
    }

    public void setValue(Object value) {
        this.value.value = value;
    }

    public void setSym(int value) {
        this.value.sym = value;
    }

    public ArrayList<TreeNode> getChilds() {
        return childs;
    }

    public void deleteChilds() {
        childs = new ArrayList();
    }

   
    String myParent;

    public Values printAndFill() {
        myParent = value.value.toString();
        System.out.println("this is the parent: " + myParent);
        graph.addNode(value.value.toString());
        graphList.add(new String[]{myParent, "", myParent});
        Values v = toString(myParent, "", true, graphList);

        /*
        for (int i = 0; i < v.list.size(); i++) {
            System.out.println("\n\n");
            System.out.println("printAndFill graphList Element 1: " + v.list.get(i)[0]);
            System.out.println("printAndFill graphList Element 2: " + v.list.get(i)[1]);
            System.out.println("\n\n");

        }
        */
        graphList = new ArrayList<String[]>(v.list);
        return v;
    }

    /*private ArrayList AddToArray(ArrayList<String[]> list){
        graphList = new ArrayList<String[]>(list);
        
    }*/
    private Values toString(String mySubParent, String indent, boolean last, ArrayList<String[]> list) {
        Values temp;

        myParent = mySubParent;
        System.out.println("this is the parent child: " + myParent);

        /*graphList = new ArrayList<String[]>();
        System.out.println("Parameter List: " + graphList.toString());
        
        for (int i = 0; i < list.size(); i++) {
            graphList.add(new String[]{list.get(i)[0].toString(),list.get(i)[1].toString()});
        }
         */
        //System.out.println("graphList: " + graphList.toString());
        String tree = indent;
        if (last) {
            tree += "└───> ";
            indent += "    ";
        } else {
            tree += "├───> ";
            indent += "│   ";
        }
        tree += value.value.toString() + "\n";
        int index = 0;
        for (TreeNode child : childs) {
            index++;
          
            StringBuilder name = new StringBuilder(myParent);

            System.out.println("This is child's name: " + child.getValue().value.toString());

            name.append(child.getValue().value.toString() + Integer.toString(index));
            //String name = myParent + child.getValue().value.toString() + Integer.toString(index);
            //graph.addNode(name).addAttribute("ui.label", name);
            list.add(new String[]{name.toString(), myParent, child.getValue().value.toString()});

            //graph.addEdge("", name, myParent);
            tree += child.toString(name.toString(), indent, index == childs.size(), list);
            //graph.display();
        }
        /*
        for (int i = 0; i < graphList.size(); i++) {
            System.out.println("\n\n");
            System.out.println("Iteration number: " + i);
            System.out.println("toString graphList Element 1: " + graphList.get(i)[0]);
            System.out.println("toString graphList Element 2: " + graphList.get(i)[1]);
            System.out.println("toString graphList Element 3: " + graphList.get(i)[2]);
            System.out.println("\n\n");
        }
        */
        temp = new Values(tree, list);
        //graph.display();
        return temp;
    }

    public boolean valueIsString(String other) {
        return this.value.value.toString().equals(other);
    }

    public void prettyPrint() {
        String indent = "";
        System.out.println(value.value);
        int index = 0;
        for (TreeNode child : childs) {
            index++;
            child.prettyPrint(indent, index == childs.size());
        }
    }

    private void prettyPrint(String indent, boolean last) {
        System.out.print(indent);
        if (last) {
            System.out.print("└───");
            indent += "    ";
        } else {
            System.out.print("├───");
            indent += "│   ";
        }
        System.out.println(value.value);
        int index = 0;
        for (TreeNode child : childs) {
            index++;
            child.prettyPrint(indent, index == childs.size());
        }
    }
    public void printGraph() {
        graph.display();
    }

    public ArrayList<TreeNode> getNodes(String value) {
        ArrayList<TreeNode> result = new ArrayList();
        if (this.value.value.equals(value)) {
            result.add(this);
        } else {
            for (TreeNode node : childs) {
                result.addAll(node.getNodes(value));
            }
        }
        return result;
    }
}
