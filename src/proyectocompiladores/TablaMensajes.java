/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyectocompiladores;

import java.util.ArrayList;

public class TablaMensajes {


    ArrayList<Mensaje> rows = new ArrayList();

    public TablaMensajes(){
        
    }

    public void resetearTabla(){
        rows.clear();
    }

    public void addMensaje(Mensaje men){
        rows.add(men);
    }


    public void imprimirTablaMensajes(){
        System.out.println("Tabla de Mensajes: ");
        System.out.println("=============================="); 

        for(Mensaje mensaje : rows){
            System.out.println(String.format(
                "| IND: %d | MEN: %s | VAR: %s | ID: %s ",
                rows.indexOf(mensaje) + 1, mensaje.mensaje, mensaje.var, mensaje.id));
        }
        System.out.println("=============================="); 
    }

    
}


