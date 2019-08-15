package t5;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;
import javafx.scene.shape.*;
import javafx.stage.Stage;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.geometry.Pos;
import javafx.scene.effect.DropShadow;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.geometry.Insets;
import java.util.ArrayList;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;

public class Tela extends Application {
    private Grafo grafo;
    private final ArrayList<Vertice> vertices = new ArrayList<>();
    private final ArrayList<Aresta> arestas = new ArrayList<>();
    private Vertice origem;
    private Vertice destino;
    private boolean estado;
    private int cont = 1;
    private String corAtual;
    private String formatoVertAtual;
    private String formatoArestAtual;
    private final Pane pane = new Pane();
    private final BorderPane borderPane = new BorderPane();

    @Override
    public void start(Stage stage) {
        // Título da janela
        stage.setTitle("EDITOR DE GRAFO");
        
        // Faz uma borda no pane
        pane.setStyle("-fx-border-color: black; -fx-border-width: 2.0");
        borderPane.setPadding(new Insets(10, 20, 10, 20));

        // Menu para os botões
        VBox menu = new VBox();
        menu.setAlignment(Pos.BASELINE_LEFT);
        menu.setSpacing(5);
        menu.setPadding(new Insets(5, 10, 10, 10));
        menu.setStyle("-fx-background-color: linear-gradient(#3c3c3c, #000000); -fx-padding: 10.0;");
        
        // Botões
        Button btnVertice = new Button("Vértice");
        Button btnAresta = new Button("Aresta");
        Button btnInfo = new Button("Informações");
        Button btnNovoGrafo = new Button("Novo Grafo");
        Button btnSVG = new Button("SALVAR EM SVG");
        Button btnSair = new Button("Sair");

        // ChoiceBoxes
        ChoiceBox cbCor = new ChoiceBox();
        ChoiceBox cbFormatoVert = new ChoiceBox();
        ChoiceBox cbFormatoArest = new ChoiceBox();
        
        // itens cores
        cbCor.getItems().addAll("Preto", "Azul", "Vermelho", "Verde");
        cbCor.setValue("Preto");
        
        // formato dos objetos
        // formato vertices 
        //cbFormatoVert.
        cbFormatoVert.getItems().addAll("Círculo", "Quadrado", "Triangulo");
        cbFormatoVert.setValue("Círculo");
        // formato arestas
        cbFormatoArest.getItems().addAll("Contínua", "Pontilhada");
        cbFormatoArest.setValue("Contínua");

        // Funções dos botões/choiceboxes do menu ao clicá-los
        botoes_menus(stage, btnVertice, btnAresta, btnSair, btnSVG, btnNovoGrafo, 
                btnInfo, cbCor, cbFormatoVert, cbFormatoArest);

        // Adiciona botões/choiceboxes no menu
        menu.getChildren().addAll(btnVertice, btnAresta, cbCor, cbFormatoVert,cbFormatoArest, btnInfo, btnNovoGrafo, btnSVG, btnSair);
        borderPane.setLeft(menu);
        borderPane.setCenter(pane);
        
        Scene scene = new Scene(borderPane, 800, 600);
        stage.setScene(scene);
        stage.show();
    }

    // Define cada botão/choicebox
    public void botoes_menus(Stage stage, Button botao_Vertice, Button botao_Aresta, Button botao_Sair, Button botao_SVG, Button botao_CrianovoGrafo, 
                          Button botao_Informacao, ChoiceBox cbCor, ChoiceBox cbFormatoVert,ChoiceBox cbFormatoArest) 
    {
        botao_Vertice.setOnMouseClicked((MouseEvent e) -> {
            estado = true;
            cont = 1;
            desenha_Vertice(cbCor, cbFormatoVert);
        });

        botao_Aresta.setOnMouseClicked((MouseEvent e) -> {
            estado = false;
            Desenha_Aresta(cbCor, cbFormatoArest);
        });

        botao_Sair.setOnMouseClicked(e -> {
            stage.close();
        });

        botao_CrianovoGrafo.setOnMouseClicked((MouseEvent e) -> {
            pane.getChildren().clear();
            vertices.clear();
            arestas.clear();
            if (grafo != null) grafo.novo_Grafo();
        });

        botao_Informacao.setOnMouseClicked((MouseEvent e) -> {
            if (grafo == null) grafo = new Grafo(vertices, arestas);
            Alert infoGrafo = new Alert(AlertType.INFORMATION);
            infoGrafo.setContentText("Vértices: " + grafo.numeros_de_Vertices() +
                    "\nArestas: " + grafo.numero_de_Arestas() +
                    "\nArestas sobrepostas: " + grafo.arestas_interseccionadas());
            infoGrafo.setHeaderText("Informações do Grafo");
            infoGrafo.showAndWait();
        });

        botao_SVG.setOnMouseClicked((MouseEvent e) -> {
            if (grafo == null) grafo = new Grafo(vertices, arestas);
            criaSVG(grafo);
            Alert avisoSalvo = new Alert(AlertType.INFORMATION);
            avisoSalvo.setHeaderText("O grafo salvo!");
            avisoSalvo.showAndWait();
        });
    }

    // Desenha aresta 
    public void Desenha_Aresta(ChoiceBox cbCor, ChoiceBox cbFormatoArest) {
        vertices.forEach((v) -> {
            v.vertShape().setOnMouseClicked(e1 -> {
                DropShadow sombra = new DropShadow();
                sombra.setOffsetY(4.0);
                if (cont == 1) {
                    origem = v;
                    origem.vertShape().setEffect(sombra);
                    origem.vertices_Conectados(origem, null);
                    cont = 2;
                }
                else if (cont == 2) { 
                    destino = v;
                    formatoArestAtual = cbFormatoArest.getValue().toString();
                    corAtual = cbCor.getValue().toString();
                    if (destino != origem && (origem.vertice_destino() != destino.vertice_destino())) {
                        Aresta aresta = new Aresta(origem, destino, corAtual, formatoArestAtual);
                        arestas.add(aresta);
                        pane.getChildren().add(aresta.criaAresta());
                        cont = 1;
                        origem.vertices_Conectados(destino, aresta);
                        destino.vertices_Conectados(origem, aresta);
                        origem.vertShape().setEffect(null);
                        origem.vertShape().toFront();
                        destino.vertShape().toFront();
                    } else cont = 2;
                }
            });
        });
    }

    // Desenha vértice
    public void desenha_Vertice(ChoiceBox cbCor, ChoiceBox cbFormatoVert) {
        pane.setOnMouseClicked(e0 -> {
            formatoVertAtual= cbFormatoVert.getValue().toString();
            corAtual = cbCor.getValue().toString();
            if (estado) {
                Vertice vertice = new Vertice(e0.getX(), e0.getY(), corAtual, formatoVertAtual);
                Shape desenho = vertice.cria_Vertices();
                if (!conflitoVert(desenho) && !(e0.getTarget() instanceof Shape)) {
                    vertices.add(vertice);
                    pane.getChildren().add(desenho);
                }
            }
        });
    }

    // para não inserir vertices acima de outro*
    public boolean conflitoVert(Shape vertAtual) {
        return vertices.stream().map((v) -> Shape.intersect(v.vertShape(), vertAtual)).anyMatch((intersect) -> (intersect.getBoundsInLocal().getWidth() != -1));
    }

    /*************************************************************/
    // Cria o arquivo SVG do grafo para ser visualizado em um browser
    public void criaSVG(Grafo grafo) {
        /* baseado no site:
            http://www.linhadecodigo.com.br/artigo/3510/introducao-ao-svg-scalable-vector-graphics.aspx
            https://www.w3schools.com/graphics/svg_intro.asp
            para verficar oque tinha que escrever
        */
        try {
            File arq = new File("grafo.svg");
            arq.createNewFile();
            try (PrintWriter escreve = new PrintWriter(arq)) {
                String header = ("<svg version='1.1' xmlns='http://www.w3.org/2000/svg'" +
                        " xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 1024 768'" +
                        " preserveAspectRatio='xMidYMid meet'>");
                escreve.println(header);
                
                // Desenha as arestas no SVG
                arestas.stream().map((Aresta a) -> {
                    double x1 = a.arestaOrigem().vertX();
                    double y1 = a.arestaOrigem().vertY();
                    double x2 = a.arestaDestino().vertX();
                    double y2 = a.arestaDestino().vertY();
                    String cor = a.arestaCor_SVG();
                    escreve.println("<line x1='" + x1 + "' y1='" + y1 + "' x2='" + x2 +"' y2='" + y2 + "' style='stroke:" + cor + ";stroke-width:2");
                    if (a.arestaPontilhada())
                        escreve.print(";stroke-dasharray:4px,3px,3px,4px;");
                    return a;
                }).forEachOrdered((_item) -> {
                    escreve.print("'/>");
                });
                // Desenha os vértices no SVG*
                vertices.forEach((Vertice v) -> {
                    double tam = v.tamnho_vertices();
                    String cor = v.Cor_do_vertice_SVG();
                    if (null == v.vertice_Formato()) {
                        escreve.println("<rect x='" + v.CentroX() + "' y='" + v.CentroY() + "' width='" + tam + "' height='" + tam + "' style='fill:" + cor + ";stroke-width:2" + ";stroke:black" + "'/>");
                    }
                    else switch (v.vertice_Formato()) {
                        case "Círculo":
                            escreve.println("<circle cx='" + v.vertX() + "' cy='" + v.vertY() + "' r='" + tam +
                                    "' stroke='black' stroke-width='2' fill='" + cor + "'/>");
                            break;
                        case "Triangulo":
                            escreve.println("<polygon points='"+ (v.vertX()-20) +","+ (v.vertY()+20) +" "+ (v.vertX()+20)+","
                                    +(v.vertY()+20)+" "+v.vertX()+","+(v.vertY()-20)+"' style='fill:"+ cor +";stroke:black"+";stroke-width:2"+ "'/>");
                            break;
                        default:
                            escreve.println("<rect x='" + v.CentroX() + "' y='" + v.CentroY() + "' width='" + tam + "' height='" + tam + "' style='fill:" + cor + ";stroke-width:2" + ";stroke:black" + "'/>");
                            break;
                    }
                }); 
                // Escreve informações sobre o grafo no SVG
                int numVert = grafo.numeros_de_Vertices();
                int numArest = grafo.numero_de_Arestas();
                int arestSobrepost = grafo.arestas_interseccionadas();
                escreve.println("<text x='10' y='30' fill='black'>" + "numero de vertices: " + numVert +"\nnumero de arestas: " + numArest +"\narestas com intersecção: " + arestSobrepost + "</text>");
                escreve.println("</svg>");
            }
        } 
        catch (IOException e) {
        }
    }
    // abre o programa
    public static void main(String[] args) {
        launch(args);
    }
}