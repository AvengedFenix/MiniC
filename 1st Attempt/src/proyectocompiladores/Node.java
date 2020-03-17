/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyectocompiladores;

import java.util.ArrayList;

/**
 *
 * @author k_k_r
 */
public class Node {

    private Node parent;
    private ArrayList<Node> children = new ArrayList();
    private Object value;

    public Node(Node nodo) {
        parent = nodo.parent;
        children = nodo.children;
        value = nodo.value;

    }

    public Node(Node nodo, Object value) {
        this.parent = parent;
        this.value = value;
    }

    public boolean addChild(Node newChild) {
        newChild.parent = this;
        return children.add(newChild);
    }

    public boolean addChild(Object value) {
        return children.add(new Node(this, value));
    }

    public Node getParent() {
        return parent;
    }

    public void setParent(Node parent) {
        this.parent = parent;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

}
