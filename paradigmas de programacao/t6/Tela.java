package tela.java;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;
import javafx.scene.shape.*;
import javafx.stage.Stage;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.geometry.Pos;
import javafx.scene.layout.HBox;
import javafx.scene.control.Alert;
import javafx.geometry.Bounds;
import javafx.geometry.Insets;
import java.util.*;
import java.util.Random;
import static javafx.application.Application.launch;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.input.MouseEvent;

public class Tela extends Application {
    private Grafo grafo;
    private ArrayList<Vertice> vertices = new ArrayList<>();
    private ArrayList<Aresta> arestas = new ArrayList<>();
    private Vertice vertAtual;
    private int dificuldadeNum = 7;
    private int cont = 1;
    private Pane pane = new Pane();
    private BorderPane borderPane = new BorderPane();
    private Bounds laterais;
    private double raioVert = Vertice.vertRaio();
    private boolean vitoria = false;
    private boolean iniciou= false;
    private int niveis = 1;
    private double cenariox = 0;
    private double cenarioy = 0;
    
    public void start(Stage stage) {
        grafo = new Grafo(vertices, arestas);
        // Título
        stage.setTitle("Planarity");
        // Faz uma borda no pane
        pane.setStyle("-fx-border-color: black; -fx-border-width: 2.0");
        borderPane.setPadding(new Insets(10, 20, 10, 20));
        HBox menu = new HBox();
        menu.setAlignment(Pos.CENTER);
        menu.setSpacing(5);
        menu.setPadding(new Insets(5, 10, 10, 10));
        // Botões
        Button btnNovoJogo = new Button("Play");
        Button btnver = new Button("verificar");
        Button btnSair = new Button("Sair");
        // Funções dos botões
        clicaMenu(stage, btnNovoJogo, btnSair, btnver);
        menu.getChildren().addAll(btnNovoJogo, btnver, btnSair);
        borderPane.setTop(menu);
        borderPane.setCenter(pane);
        // Controla o arraste dos vértices
        movimenta_vertices();
        // Faz a cena
        Scene scene = new Scene(borderPane, 800, 600);
        stage.setScene(scene);
        stage.show();
    }

   // Define a função de cada botão
   public void clicaMenu(Stage stage, Button btnNovoJogo,Button btnSair,Button btnver) {
        btnNovoJogo.setOnMouseClicked((MouseEvent e) -> {
            reinicia_Grafo();
            iniciou = true;
            niveis = 1;
            cria_GRAFO_ALT(dificuldadeNum);
        });
        btnver.setOnMouseClicked((MouseEvent e) -> {
            int avaliador =1;
            Alert aviso = new Alert(AlertType.INFORMATION);
            if(iniciou == true){
                avaliador= grafo.arestas_sobrepostas();
            }
            if (avaliador == 0){
                // mensagem venceu rodada
                aviso.setHeaderText("Parabéns, você conseguiu!\n VOCÊ ATINGIU O NIVEl:"+ niveis);
                reinicia_Grafo();
                cria_GRAFO_ALT(dificuldadeNum+cont);
                cont = cont + 1;
                niveis = niveis + 1;
            }
            else if(iniciou == false){
                aviso.setHeaderText("JOGO NÃO INICIADO");
                // mensagem não iniciou o jogo ainda
            }else{
                // mensagem ainda ha instesecções
                aviso.setHeaderText("TENTE NOVAMENTE");
            }
            aviso.showAndWait();
        });
        btnSair.setOnMouseClicked(e -> {
            stage.close();
        });
    }
    // Gera o grafo
    public void cria_GRAFO_ALT(int dificuldade) {
        double distCircs = raioVert*2;
        Random random = new Random();
        double chanceAresta = 0.8;
        laterais = pane.getBoundsInParent();
        double maxPosX = laterais.getMaxX() - distCircs*4;
        double minPosX = laterais.getMinX() + distCircs/2;
        double maxPosY = laterais.getMaxY() - distCircs*4.5;
        double minPosY = laterais.getMinY()/2;
        double n_vert = dificuldade;
        for (int i = 0; i < n_vert; i++) {
            Vertice novoVert = 
                new Vertice(random.nextInt((int) (maxPosX - minPosX + distCircs)) + minPosX,
                            random.nextInt((int) (maxPosY - minPosY + distCircs)) + minPosY);
            if (!bloqueios_vertices(novoVert)) {
                vertices.add(novoVert);
                pane.getChildren().add(novoVert.criaVert());
            }
        }
        int linhaLen = (int) Math.sqrt(vertices.size());
        for (int i = 0; i < vertices.size(); i++) {
            int xn = i % linhaLen;
            int yn = i / linhaLen;
            for (int dy = -1; dy <= 0; dy++) {
                for (int dx = -1; dx <= 0; dx++) {
                    int x = xn + dx;
                    int y = yn + dy;
                    double rnd = random.nextFloat();
                    if (x >= 0 && y >= 0 && (dx != 0 || dy != 0) && rnd < chanceAresta) {
                        int j = x + y * linhaLen;
                        Vertice v1 = vertices.get(i);
                        Vertice v2 = vertices.get(j);
                        Aresta a = new Aresta(v1, v2);
                        arestas.add(a);
                        v1.vertConecta(v2, a);
                        v2.vertConecta(v1, a);
                        v1.vertShape().toFront();
                        v2.vertShape().toFront();
                        pane.getChildren().add(a.criaAresta());
                    }
                }
            }
        }
        remove_vertices_SEM_conexao();
    }
    public void remove_vertices_SEM_conexao() {
        if (vertices.size() > 0) {
            for(int i = 0; i < vertices.size(); i++) {
                Vertice v = vertices.get(i);
                if (v.vertQuantArestas() == 0) {
                    pane.getChildren().remove(v.vertShape());
                    vertices.remove(i);
                }
            }
        }
    }
    public boolean bloqueios_vertices(Vertice vertInserido) {
        if (vertices.size() > 0) {
            for(Vertice v : vertices) {   
                double difY = v.vertY() - vertInserido.vertY();
                double difX = v.vertX() - vertInserido.vertX();
                double distQuad = difX * difX + difY * difY;
                double somaRaios = Vertice.vertRaio() + Vertice.vertRaio();
                if (distQuad < (somaRaios * somaRaios)) 
                    return true;
            }
        }
        return false;
    }
    public void movimenta_vertices() {
        pane.setOnMousePressed(e0 -> {
            vertices.stream().map((v) -> {
                v.vertShape().toFront();
                return v;
            }).filter((v) -> (v.vertShape() == e0.getTarget())).map((v) -> {
                vertAtual = v;
                return v;
            }).map((_item) -> {
                cenariox = e0.getSceneX();
                return _item;
            }).forEachOrdered((_item) -> {
                cenarioy = e0.getSceneY();
            });
        });

        pane.setOnMouseDragged(e1 -> {
            if (vertAtual != null) {
                vertAtual.vertShape().setOnMouseDragged(e2 -> {
                    double offsetX = e2.getSceneX() - cenariox;
                    double offsetY = e2.getSceneY() - cenarioy;
                    Circle c = (Circle) vertAtual.vertShape();
                    double x = c.getCenterX() + offsetX;
                    double y = c.getCenterY() + offsetY;
                    if (dentro_do_cenario_X(x)) {
                        vertAtual.setVertX(vertAtual.vertX() + offsetX);
                        c.setCenterX(c.getCenterX() + offsetX);
                        cenariox = e2.getSceneX();
                    }
                    if (dentro_do_cenario_Y(y)) {
                        vertAtual.setVertY(vertAtual.vertY() + offsetY);
                        c.setCenterY(c.getCenterY() + offsetY);
                        cenarioy = e2.getSceneY();
                    }
                    reconectaArestas();
                });
                vertAtual.vertShape().setOnMouseReleased(e3 -> {
                    arestasCorDefault();
                    vertAtual.setVertCorDefault();
                });
            }
        });
    }
    public boolean dentro_do_cenario_Y(double y) {
        return (y <= laterais.getMaxY() - raioVert*6) && (y >= laterais.getMinY() - raioVert*4);
    }
    public boolean dentro_do_cenario_X(double x) {
        return (x <= laterais.getMaxX() - raioVert*3) && (x >= laterais.getMinX() - raioVert);
    }
    public void reconectaArestas() {
        vertAtual.vertArestasConectadas().stream().map((a) -> {
            a.atualizaAresta(vertAtual); 
            return a;
        }).map((a) -> {
            return a;
        }).forEachOrdered((_item) -> {      
        });
    }
    public void reinicia_Grafo() {
        if (grafo != null) grafo.novo_grafo();
        arestas.clear();
        vertices.clear();
        pane.getChildren().clear();
    }
 
    public void arestasCorDefault() {
        vertAtual.vertArestasConectadas().forEach((a) -> {
            a.arestaCorDefault();
        });
    }
    public static void main(String[] args) {
        launch(args);
    }

}
