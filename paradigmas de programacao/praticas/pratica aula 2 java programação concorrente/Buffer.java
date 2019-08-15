package javaapplication1;

public class Buffer {
    private int conteudo, tamanho = 5;
    private boolean disponivel;
    
    public int getTamanho(){
        return tamanho;
    }
    
    public synchronized void set(int idProdutor, int valor){
        while(disponivel == true){
            try{
                System.out.println(" + produtor #" + idProdutor + " esperando..");
                wait();
            } catch (Exception e){
                System.out.println("Erro: " +e);
            }
        }
        conteudo = valor;
        System.out.println(" + Produtor #" + idProdutor + " colocou "+ conteudo);
        disponivel = true;
        notifyAll();
    } 
    
    public synchronized void get(int idConsumidor){
        while(disponivel == false){
            try{
                System.out.println("Consumidor #" + idConsumidor + "esperando..");
                wait();
            } catch(Exception e){
                
            }
        }
        System.out.println(" + Consumidor #" + idConsumidor + " retirou "+ conteudo);
        disponivel = false;
        notifyAll();
    }
}

