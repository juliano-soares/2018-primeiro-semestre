package t5;
import javafx.scene.shape.Line;
import javafx.scene.layout.Pane;

public class Aresta extends Pane {
    private final String formato;
    private Line linha;
    private final String cor;
    private final Vertice ori;
    private final Vertice dest;
    
    public Aresta(Vertice origem, Vertice destino, String cor, String formato) {
        this.ori = origem;
        this.dest = destino;
        this.cor = cor;
        this.formato = formato;
    }

    public Line criaAresta() {
        Line l = new Line(this.ori.vertX(), this.ori.vertY(), 
                          this.dest.vertX(), this.dest.vertY());
        l.setStyle(arestaCor());
        if ("Pontilhada".equals(this.formato)) 
              l.getStrokeDashArray().addAll(4.0, 3.0, 3.0, 4.0);
        this.linha = l;
        return l;
    }

    public String arestaCor_SVG() {
        if (null != this.cor) switch (this.cor) {
            case "Azul":
                return "blue";
            case "Vermelho":
                return "red";
            case "Verde":
                return "green";
            default:
                break;
        }
        return "black";
    }
    
    public String arestaCor() {
        if (null != this.cor) switch (this.cor) {
            case "Azul":
                return "-fx-stroke: blue;";
            case "Vermelho":
                return "-fx-stroke: red;";
            case "Verde":
                return "-fx-stroke: green;";
            default:
                break;
        }
        return "-fx-stroke: black;";
    }

    public boolean arestaPontilhada() {
        return "Pontilhada".equals(this.formato);
    }

    public Line arestaLinha() {
        return this.linha;
    }

    public Vertice arestaOrigem() {
        return this.ori;
    }

    public Vertice arestaDestino() {
        return this.dest;
    }
}
