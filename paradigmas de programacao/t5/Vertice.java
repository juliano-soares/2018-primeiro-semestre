package t5;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.*;
import java.util.ArrayList;

public class Vertice extends Pane {
    private final double x;
    private final double y;
    private final double raio = 15;
    private final double tam_Q = 15*2;
    private final double size = 15;
    private final String forma;
    private final String cor;
    private Shape shape;
    private Vertice destino;
    private final ArrayList<Aresta> arestasConc;

    public Vertice(double x, double y, String cor, String formato) {
        this.x = x;
        this.y = y;
        this.cor = cor;
        this.forma = formato;
        this.arestasConc = new ArrayList<>();
    }

    public Shape cria_Vertices() {
        Shape f;

        if (null == this.forma) f = new Rectangle(this.x-(tam_Q/2), this.y-(tam_Q/2), tam_Q, tam_Q);
        else switch (this.forma) {
            case "Círculo":
                f = new Circle(this.x, this.y, raio);
                break;
            case "Triangulo":
                f = new Polygon(new double[]{this.x-(size), this.y+(size), this.x+(size), this.y+(size), this.x, this.y-(size)});
                break;
            default:
                f = new Rectangle(this.x-(tam_Q/2), this.y-(tam_Q/2), tam_Q, tam_Q);
                break;
        }
        f.setFill(Cor_do_vertice());
        this.shape = f;
        return f;
    }

    public String vertice_Formato() {
        return this.forma;
    }

    public Shape vertShape() {
        return this.shape;
    }

    public Color Cor_do_vertice() {
        if (null != this.cor) switch (this.cor) {
            case "Azul":
                return Color.BLUE;
            case "Vermelho":
                return Color.RED;
            case "Verde":
                return Color.GREEN;
            default:
                break;
        }
        return Color.BLACK;
    }

    public String Cor_do_vertice_SVG() {
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
    
    public double vertX() {
        return this.x;
    }

    public double vertY() {
        return this.y;
    }

    public double CentroX() {
        if ("Quadrado".equals(this.forma)) 
            return this.x-(this.tam_Q/2);
        return this.vertX();
    }

    public double CentroY() {
        if ("Quadrado".equals(this.forma)) 
            return this.y-(this.tam_Q/2);
        return this.vertY();
    }

    public double tamnho_vertices() {
        if ("Círculo".equals(this.forma)) {
            return this.raio;
        } else {
            return this.tam_Q;
        }
    }

    public void vertices_Conectados(Vertice destino, Aresta aresta) {
        this.destino = destino;
        if (this != destino && aresta != null) {
            arestasConc.add(aresta);
        }
    }
    
    public Vertice vertice_destino() {
        return this.destino;
    }

    public int vert_Q_Arestas() {
        return this.arestasConc.size();
    }

    public ArrayList V_A_Conectadas() {
        return this.arestasConc;
    }
}