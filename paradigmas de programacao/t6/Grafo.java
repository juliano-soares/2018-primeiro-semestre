package tela.java;
import javafx.scene.shape.*;
import java.util.ArrayList;

public class Grafo {
    public ArrayList<Vertice> vertices = new ArrayList<>();
    public ArrayList<Aresta> arestas = new ArrayList<>();
    public Grafo(ArrayList<Vertice> vertices, ArrayList<Aresta> arestas) {
        this.vertices = vertices;
        this.arestas = arestas;
    }
    public int n_Vertices() {
        return this.vertices.size();
    }
    public void novo_grafo() {
        this.vertices.clear();
        this.arestas.clear();
    }
    public int n_arestas() {
        return this.arestas.size();
    }
    public int interseccao_Arestas(ArrayList<Aresta> listaAresta) {
        int cont = 0;
        for (int i = 0; i < listaAresta.size(); i++) {
            for (int j = i+1; j < listaAresta.size();  j++) {
                Shape intersect = Shape.intersect(listaAresta.get(i).arestaLinha(), 
                                                  listaAresta.get(j).arestaLinha());
                if (intersect.getBoundsInLocal().getWidth() != -1) 
                    cont++;
            }
        }
        return cont;
    }
    public int sobrepos_Arest_Vert() {
        int cont = 0;
        cont = this.vertices.stream().map((v) -> v.vertArestasConectadas()).map((conexoes) -> interseccao_Arestas(conexoes)).reduce(cont, Integer::sum);
        return cont;
    }
    public int arestas_sobrepostas() {
        return interseccao_Arestas(this.arestas) - sobrepos_Arest_Vert();
    }
}
