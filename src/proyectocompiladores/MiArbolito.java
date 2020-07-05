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

public class MiArbolito {

    public ArrayList<String[]> graphList = new ArrayList<String[]>();
    Graph graph = new SingleGraph("AST");

    private MiArbolito parent;
    private ArrayList<MiArbolito> children = new ArrayList();
    private Symbol value;
    private String Lugar = "";
    private String Verdadera = "";
    private String Falsa = "";
    private String Siguiente = "";
    private boolean visitado = false;

    public MiArbolito(MiArbolito copy) {
        parent = copy.parent;
        children = copy.children;
        value = copy.value;
    }

    public MiArbolito(MiArbolito parent, Symbol value) {
        this.parent = parent;
        this.value = value;
    }

    public MiArbolito(MiArbolito parent, String value) {
        this.parent = parent;
        this.value = new Symbol(-1, 0, 0, value);
    }

    public boolean addChild(MiArbolito newChild) {
        newChild.parent = this;
        return children.add(newChild);
    }

    public boolean addChild(Object value) {
        return children.add(new MiArbolito(this, (Symbol) value));
    }

    public void setParent(MiArbolito parent) {
        this.parent = parent;
    }

    public void removeParent() {
        this.parent = null;
    }

    public MiArbolito getParent() {
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

    public ArrayList<MiArbolito> getChildren() {
        return children;
    }

    public void deleteChildren() {
        children = new ArrayList();
    }

    public void setLugar(String Lugar){
        this.Lugar = Lugar;
    }

    public void setVerdadera(String Verdadera){
        this.Verdadera = Verdadera;
    }

    public void setFalsa(String Falsa){
        this.Falsa = Falsa;
    }

    public void setSiguiente(String Siguiente){
        this.Siguiente = Siguiente;
    }

    public void setVisitado(){
        this.visitado =  true;
    }

    public boolean getVisitado(){
        return this.visitado;
    }

    public String getLugar(){
        return this.Lugar;
    }

    public String getVerdadera(){
        return this.Verdadera;
    }

    public String getFalsa(){
        return this.Falsa;
    }

    public String getSiguiente(){
        return this.Siguiente;
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

    private Values toString(String mySubParent, String indent, boolean last, ArrayList<String[]> list) {
        Values temp;

        myParent = mySubParent;
        //System.out.println("this is the parent child: " + myParent);

        /*graphList = new ArrayList<String[]>();
        System.out.println("Parameter List: " + graphList.toString());
        
        for (int i = 0; i < list.size(); i++) {
            graphList.add(new String[]{list.get(i)[0].toString(),list.get(i)[1].toString()});
        }
         */
        //System.out.println("graphList: " + graphList.toString());
        String tree = indent;
        if (last) {
            tree += "\\\\~~~~:> ";
            indent += "    ";
        } else {
            tree += "\\\\~~~~:> ";
            indent += "||   ";
        }
        tree += value.value.toString() + "\n";
        int index = 0;
        for (MiArbolito child : children) {
            index++;

            StringBuilder name = new StringBuilder(myParent);

            //System.out.println("This is child's name: " + child.getValue().value.toString());
            name.append(child.getValue().value.toString() + Integer.toString(index));
            //String name = myParent + child.getValue().value.toString() + Integer.toString(index);
            //graph.addNode(name).addAttribute("ui.label", name);
            list.add(new String[]{name.toString(), myParent, child.getValue().value.toString()});

            //graph.addEdge("", name, myParent);
            tree += child.toString(name.toString(), indent, index == children.size(), list);
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

    public ArrayList<MiArbolito> getNodes(String value) {
        ArrayList<MiArbolito> result = new ArrayList();
        if (this.value.value.equals(value)) {
            result.add(this);
        } else {
            for (MiArbolito node : children) {
                result.addAll(node.getNodes(value));
            }
        }
        return result;
    }

    
    public void reduce() {
        if (children.size() == 1) {
            value = children.get(0).value;
            children = children.get(0).children;
            this.reduce();
        }
        if (children.size() > 1) {
            for (MiArbolito child : children) {
                child.reduce();
            }
        }
    }
}

