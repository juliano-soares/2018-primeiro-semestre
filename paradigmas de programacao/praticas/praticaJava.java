abstract class Bloco {
    public abstract Bloco quebra(String a);
}

class Terra extends Bloco {
    // pode quebrar com qualquer coisa 
    // dropa terra
    protected String name;
    public Terra() {
        name = "Terra";
        System.out.println(name);
    }public Terra(int a) {
        name = "Dropou = Terra";
        System.out.println(name);
    }
    @Override
    public Bloco quebra(String a) {
        return new Terra(1);
    }
}

class Pedra extends Bloco {

    protected String name;
    public Pedra() {
        name = "Pedra";
        System.out.println(name);
    }public Pedra(int n) {
        name = "Dropou = Pedra";
        System.out.println(name);
    }
    // so pode ser quebrada com a picareta 
    // dropa pedregulho
    @Override
    public Bloco quebra(String a) {
        if (a.equals("picareta")){
            return new Pedra(1); 
        }
        return new Pedra();
    }  
}

class Madeira extends Bloco {
    // se quebrar dropa madeira
    protected String name;
    public Madeira() {
        name = "Terra";
        System.out.println(name);
    }public Madeira(int a) {
        name = "Dropou = Madeira";
        System.out.println(name);
    }
    @Override
    public Bloco quebra(String a) {
        return new Madeira(1);
    }
    
}
class Grama extends Bloco {
    // se quebrar com pá dropa grama se não terra
    protected String name;
    public Grama() {
        name = "Grama";
        System.out.println(name);
    }public Grama(int a) {
        name = "Dropou = Grama";
        System.out.println(name);
    }
    @Override
    public Bloco quebra(String a) {
        if (a.equals("pa")){
            return new Grama(1); 
        }
        return new Terra(1);
    }
}
class Main {
 public static void main(String[] args) {
   Terra t = new Terra();
   t.quebra("pa");
   Pedra p = new Pedra();
   p.quebra("picareta");
 }
}
