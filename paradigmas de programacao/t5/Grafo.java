package t5;
import javafx.scene.shape.*;
import java.util.ArrayList;

public class Grafo {
    public ArrayList<Vertice> vertices = new ArrayList<>();
    public ArrayList<Aresta> arestas = new ArrayList<>();

    // Construtor
    public Grafo(ArrayList<Vertice> vertices, ArrayList<Aresta> arestas) {
        this.vertices = vertices;
        this.arestas = arestas;
    }

    // Retorna o n° de vértices
    public int numeros_de_Vertices() {
        return this.vertices.size();
    }

    // Retorna o n° de arestas
    public int numero_de_Arestas() {
        return this.arestas.size();
    }

    // apaga o grafo antigo
    public void novo_Grafo() {
        this.vertices.clear();
        this.arestas.clear();
    }

    // Retorna arestas sobrepostas
    public int verifica_sobrepostas(ArrayList<Aresta> listaAresta) {
        int cont = 0;
        int i,j;
        for (i = 0; i < listaAresta.size(); i++) {
            for (j = i+1; j < listaAresta.size();  j++) {
                Shape intersect = Shape.intersect(listaAresta.get(i).arestaLinha(),listaAresta.get(j).arestaLinha());
                if (intersect.getBoundsInLocal().getWidth() != -1)cont++;
            }
        }
        return cont;
    }

    // Returna arestas sobrepostas dentro de um vértice
    public int sobreposArestVert() {
        int cont = 0;
        for (Vertice v : this.vertices) {
            ArrayList<Aresta> conexoes = v.V_A_Conectadas();
            cont += verifica_sobrepostas(conexoes);
        }
        return cont;
    }
    
    public int arestas_interseccionadas() {
        return verifica_sobrepostas(this.arestas) - sobreposArestVert();
    }
    
}