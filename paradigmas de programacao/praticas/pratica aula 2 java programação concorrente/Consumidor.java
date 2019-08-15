package javaapplication1;


import javaapplication1.Buffer;


public class Consumidor extends Thread{
    private int idConsumidor;
    private Buffer pilha;
    
    public Consumidor(int id, Buffer p){
        idConsumidor = id;
        pilha = p;
    }

    public void run(){
        pilha.get(idConsumidor);
        System.out.println("Consumidor #" + idConsumidor +" concluido");
    }
    
}

