/**
 *
 * @author juliano leonardo soares
 * 
 */
package javaapplication5;
import java.util.ArrayList;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.PieChart;
import javafx.scene.control.Label;
import javafx.scene.control.Separator;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.web.WebView;
import javafx.util.Callback;

public class View extends Application {
    private BarChart<String,Number> G_barra;
    private Label titulo; 
    private TableView<Dados> table;
    private ArrayList<Label> data, andress;
    private PieChart G_pizza;
    private WebView mapa;
    private final controller controller = new controller(table, G_pizza, G_barra, data);
    
/**********************************************************************************************/    
    /// configurações do conteudo apresentado 
    private Parent conteudo(Stage stage) throws InterruptedException{ 
        /// inicia os objetos a serem usados
        inicializador_de_objetos(); 
/**********************************************************************************************/        
        // Pane esquerdo
        /// vobox dos graficos (pizza e em barras)
        VBox vbesquerda = getVBox(); 
        VBox vbdireita = getVBox();
        VBox vbcentro = getVBox();
        VBox vbTitulo = new VBox();
        vbTitulo.setAlignment(Pos.CENTER);
        VBox vbDatas = new VBox();
        VBox vbEndereco = getVBox();
        VBox vbMenu = new VBox();
        VBox vbTop = getVBox();
        HBox hbbotoes = getHBox();
        Separator g = new Separator();
        vbesquerda.getChildren().addAll(vbMenu,table,g, vbDatas);
        vbdireita.getChildren().addAll(mapa,vbEndereco);
        vbcentro.getChildren().addAll(G_pizza, g, G_barra);
        vbTop.getChildren().addAll(vbTitulo);
        vbMenu.getChildren().addAll(hbbotoes);
        vbTitulo.getChildren().add(titulo);
        vbDatas.getChildren().addAll(data); 
        vbEndereco.getChildren().addAll(andress);
        
        hbbotoes.getChildren().addAll(
            controller.get_busca_todos_onibus(table, G_pizza, G_barra, data),
            controller.getJsonFileButton(table, G_pizza, G_barra, data, stage),
            controller.get_busca_linha(table, G_pizza, G_barra, data),
            controller.get_busca_Onibus(table, G_pizza, G_barra, data)
        );
        // BorderPane/pane principal
        BorderPane borderPane = new BorderPane();
        borderPane.setLeft(vbesquerda);
        borderPane.setCenter(vbcentro);
        borderPane.setRight(vbdireita);
        borderPane.setTop(vbTop);
        borderPane.setStyle("-fx-background-color: grey");
        return borderPane;   
    }
/**********************************************************************************************/     
    /// funções de inicialização de objetos
    private void inicializador_de_objetos(){
        // Inicializacoes
        /// texto titulo projeto
        titulo = new Label("  Dashboard para monitoramento de frota de ônibus urbanos na cidade do Rio de Janeiro");
        titulo.setFont(new Font("Arial", 22));       
        inicia_frase();   /// iniciasliza textos
        inicia_tabela();/// inicializa tabelas
        inicia_grafico_pizza(); /// inicializa grafico em pizza 
        inicia_grafico_barras(); /// inicializa grafico em barras
        abre_mapa();  /// inicializa mapa
    }
/**********************************************************************************************/    
    /// inicializador do JAVAFX
    @Override
    public void start(Stage stage) throws InterruptedException{
        Scene scene = new Scene(conteudo(stage), 1300, 750);
        stage.setTitle("Dashboard para monitoramento de frota de ônibus urbanos");
        stage.setScene(scene);
        stage.setMinWidth(1300);
        stage.setMaximized(true);
        stage.show();
    }
/**********************************************************************************************/
    /// configurações para o grafico em pizza
    private void inicia_grafico_pizza() {
        G_pizza = new PieChart();
        G_pizza.setMinWidth(350);
        G_pizza.setPrefWidth(350);
        controller.atualiza_grafico_pizza(G_pizza);
    }
/**********************************************************************************************/
    /// configurações para o grafico em barras
    private void inicia_grafico_barras() {
        final CategoryAxis linha = new CategoryAxis();
        final NumberAxis n_veiculos = new NumberAxis();
        linha.setLabel("Linha");       
        n_veiculos.setLabel("n° de ônibus");
        G_barra = new BarChart<>(linha,n_veiculos);
        G_barra.setTitle("N° de veiculos em movimento por linha");
        G_barra.setMinWidth(350);
        G_barra.setPrefWidth(350);
        G_barra.setLegendVisible(false);
        controller.atualiza_grafico_em_barras(G_barra);
    }
/**********************************************************************************************/
    /// configurações e localização dos textos/frases/avisos
    private void inicia_frase() {
        data = new ArrayList<>();
        for(int i=1;i<4;i++){
            data.add(new Label());
        }
        data.forEach((l) -> {
            l.setFont(new Font("Arial", 14));
        });
        controller.atualiza_Textos(data);
        andress = new ArrayList<>();
        for(int i=1;i<6;i++){
            andress.add(new Label());
        }
        andress.forEach((l) -> {
            l.setFont(new Font("Arial", 14));
        });
        controller.atualizaEndereco(andress, "Rio de Janeiro - RJ, Brasil");
    }
/**********************************************************************************************/
    /// mapa do google 
    private void abre_mapa() {
        mapa = new WebView();
        mapa.setPrefSize(350, 600);
        mapa.getEngine().load("https://maps.googleapis.com/maps/api/staticmap?center=Rio+de+Janeiro,RJ,Brazil&size="+350+"x"+600+"&zoom="+"10"+"&maptype=roadmap");
    }
/**********************************************************************************************/
    /// configurações VBOX
    private VBox getVBox() {
        VBox vb = new VBox();
        vb.setSpacing(5);
        vb.setPadding(new Insets(10, 10, 10, 10));
        return vb;
    }
/**********************************************************************************************/
    /// configurações HBOX
    private HBox getHBox() {
        HBox hb = new HBox();
        hb.setSpacing(5);
        hb.setPadding(new Insets(10, 10, 10, 10));
        hb.setAlignment(Pos.CENTER);
        return hb;
    }
/**********************************************************************************************/
    private void inicia_tabela() {
        table = new TableView<>();
        table.setMaxSize(600, 620);
        Callback<TableColumn<Dados,String>,TableCell<Dados,String>> cellFactory;
        cellFactory = new Callback<TableColumn<Dados,String>,TableCell<Dados,String>>() {
            @Override
            public TableCell<Dados,String> call(TableColumn p) {
                TableCell<Dados,String> cell = new TableCell<Dados,String>() {
                    @Override
                    public void updateItem(String item, boolean empty) {
                        super.updateItem(item, empty);
                        setText((item == null || empty) ? "" : getItem());
                    }
                };
                cell.addEventFilter(MouseEvent.MOUSE_CLICKED, (MouseEvent t) -> {
                    int id = ((TableCell)t.getSource()).getIndex();
                    controller.atualiza_mapa(mapa, andress,
                            table.getItems().get(id).getLatitude(),
                            table.getItems().get(id).getLongitude());
                });
                return cell;
            }
        };
        TableColumn<Dados,String> dataCol = new TableColumn<>("Data");
        TableColumn<Dados,String> ordemCol = new TableColumn<>("Ordem");
        TableColumn<Dados,String> linhaCol = new TableColumn<>("Linha");
        TableColumn<Dados,String> latitudeCol = new TableColumn<>("Latitude");
        TableColumn<Dados,String> longitudeCol = new TableColumn<>("Longitude");
        TableColumn<Dados,String> velocidadeCol = new TableColumn<>("Velocidade");
        dataCol.setCellValueFactory(cellData -> cellData.getValue().dataProperty());
        dataCol.prefWidthProperty().bind(table.widthProperty().multiply(0.27));               
        ordemCol.setCellValueFactory(cellData -> cellData.getValue().ordemProperty());
        linhaCol.setCellValueFactory(cellData -> cellData.getValue().linhaProperty());       
        latitudeCol.setCellValueFactory(cellData -> cellData.getValue().latitudeProperty());               
        longitudeCol.setCellValueFactory(cellData -> cellData.getValue().longitudeProperty());          
        velocidadeCol.setCellValueFactory(cellData -> cellData.getValue().velocidadeProperty());      
        table.getColumns().add(dataCol); 
        table.getColumns().add(linhaCol);
        table.getColumns().add(ordemCol);
        table.getColumns().add(latitudeCol);
        table.getColumns().add(longitudeCol);
        table.getColumns().add(velocidadeCol);

        for (TableColumn tc : table.getColumns())
            tc.setCellFactory(cellFactory);
    }
/**********************************************************************************************/
    /// função principal
    public static void main(String[] args) {
        launch(args);
    }

}
