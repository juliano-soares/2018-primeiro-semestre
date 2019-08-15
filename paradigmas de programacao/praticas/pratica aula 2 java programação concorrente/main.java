package javaapplication1;


public class main{

    public static void main(String[] args){
        Buffer buffercomp = new Buffer();
        Produtor produtor1 = new Produtor(1, buffercomp);     
        Consumidor consumidor1 = new Consumidor(1, buffercomp);
        produtor1.start();
        consumidor1.start();
    }
}
