package proyectocompiladores;

import java.util.ArrayList;

public class Table {

    Table parent = null;
    ArrayList<TableRow> rows = new ArrayList();
    ArrayList<Table> childs = new ArrayList();

    public Table() {
    }

    public Table(Table parent) {
        this.parent = parent;
    }

    public Values addTableRow(TableRow to_add) {
        Values v;
        v = new Values(false);
        TableRow result = searchLocal(to_add);
        if (result == null) {
            this.rows.add(to_add);
            v = new Values(true);
            return v;
        } else {
            String error = "Error en variable " + to_add.id + ", ya ha sido declarada";
            System.err.println(error);
            v = new Values(false, error);
        }
        return v;
    }

    public Values addTableRow(String id, Object value, String type, int offset) {
        Values v;
        v = new Values(false);
        TableRow to_add = new TableRow(id, value, type, offset);
        TableRow result = searchLocal(to_add);
        if (result == null) {
            this.rows.add(to_add);
            v = new Values(true);
            return v;
        } else {
            String error = "Error en variable " + id + ", ya ha sido declarada";
            System.err.println(error);
            v = new Values(false, error);
        }
        return v;
    }

    public void setParent(Table parent) {
        this.parent = parent;
    }

    public void addChild(Table child) {
        child.parent = this;
        childs.add(child);
    }

    public TableRow searchLocal(TableRow id) {
        for (TableRow row : rows) {
            if (row.equals(id)) {
                return row;
            }
        }
        return null;
    }

    public TableRow search(TableRow id) {
        for (TableRow row : rows) {
            if (row.equals(id)) {
                return row;
            }
        }
        if (parent != null) {
            return parent.search(id);
        }
        return null;
    }

    public TableRow search(String id) {
        try {
            for (TableRow row : rows) {
                if (row.id.equals(id)) {
                    return row;
                }
            }
            if (parent != null) {
                return parent.search(id);
            }
            return null;
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getActualOffset() {
        if (rows.size() > 0) {
            TableRow lastRow = rows.get(rows.size() - 1);
            return lastRow.offset + getTypeSize(lastRow.type);
        }
        return 0;
    }

    public ArrayList<Table> getChilds() {
        return childs;
    }

    public void print() {
        System.out.println("PARENT");
        for (TableRow tr : this.rows) {
            System.out.println(tr.toString());
        }

        int size = childs.size();
        System.out.println("CHILD SIZE=" + size);
        for (int i = 0; i < size; i++) {
            System.out.printf("CHILD[%d] DATA\n", i);
            childs.get(i).print();
            System.out.println();
        }
    }

    public static int getTypeSize(String type) {
        switch (type) {
            case "char":
                return 1;
            case "short":
                return 2;
            case "int":
            case "long":
            case "float":
                return 4;
            case "double":
                return 8;
        }
        if (type.contains("->") || type.contains("Pointer")) {
            return 4;
        }
        return 0;
    }
}
