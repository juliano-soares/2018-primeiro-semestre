package javaapplication1;

public class Produtor extends Thread {
    private int idProdutor;
    private Buffer pilha;
    
    public Produtor(int id, Buffer p){
        idProdutor = id;
        pilha = p;
    }

    public void run(){
        pilha.set(idProdutor, pilha.getTamanho());
        System.out.println("+ Produtor #" + idProdutor + " concluido!");
    }
}

