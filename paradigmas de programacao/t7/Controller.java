package javaapplication5;

import java.io.File;
import java.util.ArrayList;
import java.util.Optional;
import java.util.function.Consumer;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.PieChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;
import javafx.scene.control.TextInputDialog;
import javafx.scene.text.Font;
import javafx.scene.web.WebView;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class controller extends Thread{
    private final Model model = new Model();
    private final TableView<Dados> tabela;
    private final PieChart G_pizza;
    private final BarChart G_barras;
    private final ArrayList<Label> frases;
    
    public controller(TableView<Dados> tabela, PieChart pizza, BarChart barra, ArrayList<Label> frases){
        this.G_barras = barra;
        this.frases = frases;
        this.G_pizza = pizza;
        this.tabela = tabela;    
    }
    public void run(){
        /*
         tentativa de threads fracassada
            atualizar os dados ate que foi bem facil porém na hora de atualizar 
            os graficos ficou algo muito estranho e que demorava muito a execução
            e causavam alguns erros de na hora de mosifica-los.
            e resolvi pesquisar melhor e vi que o javafx precisava ser diferente mas so
            vi tutoriais em ingles e que não entendi como fazia a mudança apenas mudava uma vez e na
            segunda causava um erro que pausava o thread por segurança o que causava a demora na mudança
            dos dados e resolvi tirar.
        */
    }  

    public void metodo(TableView<Dados> tabela, PieChart pizza, BarChart barra, ArrayList<Label> frases,Optional<String> result, int verificador){
        ObservableList<Dados> observable = FXCollections.observableArrayList();
        switch(verificador){
            case 1:
                dados_de_todos_onibus().forEach(observable::add);
                break;
            case 2:
                dados_da_Linha(result.get()).forEach(observable::add);
                break;
            case 3:
                dados_do_Onibus(result.get()).forEach(observable::add);
                break;
        }
        tabela.setItems(observable);
        atualiza_Textos(frases);
        atualiza_grafico_pizza(pizza);
        atualiza_grafico_em_barras(barra);
    }
    
    public void atualiza_Textos(ArrayList<Label> frase) {
        frase.get(0).setText("Ultima leitura:\t" + model.get_Data_Ultima());
        frase.get(1).setText("Data mais recente:  \t" + model.get_Data_Nova());
        frase.get(2).setText("Data menos recente: \t" + model.get_Data_antiga());
    }

    public void atualizaEndereco(ArrayList<Label> frases, String endStr) {
        System.out.println("Atualizando para endereco : " + endStr);
        int idx;
        String[] endArray = endStr.split(", ");
        for (idx = 0; idx < endArray.length; idx++) {
            if (endArray[idx].length() > 40)
                endArray[idx] = endArray[idx].substring(0,36) + "...";
            frases.get(idx).setText(endArray[idx]);
        }
        for (; idx < frases.size(); idx++)
            frases.get(idx).setText("");
    }

    public void atualiza_grafico_pizza(PieChart pizza) {
        int total = model.get_total_veiculos();
        int parados = model.get_Veiculos_Parados();
        pizza.setTitle(total + " veiculos na ultima leitura");
        ObservableList<PieChart.Data> pieChartData =
                FXCollections.observableArrayList(
                new PieChart.Data(parados + " parado(s)", parados),
                new PieChart.Data((total-parados) + " em movimento", (total-parados)));
        pizza.setData(pieChartData);
    }

    public void atualiza_grafico_em_barras(BarChart barra) {
        XYChart.Series<String,Number> barras = new XYChart.Series<>();
        ArrayList<String> linhas = model.get_Linhas();
        linhas.forEach(new Consumer<String>() {
            @Override
            public void accept(String l) {
                int veiculos = model.get_Veiculos_movimento_linha(l);
                if (veiculos > 0) {
                    barras.getData().add(new XYChart.Data<>(l, veiculos));
                }
            }
        });
        barra.getData().clear();
        barra.getData().add(barras);
    }

    public void atualiza_mapa(WebView mapa, ArrayList<Label> end, double lat, double lng) {
        int width = (int)mapa.getWidth();
        int height = (int)mapa.getHeight();
        mapa.getEngine().load("https://maps.googleapis.com/maps/api/staticmap?size="+width+"x"+height+"&zoom=16&maptype=roadmap&markers=icon:https://goo.gl/xpmPM1%7C"+lat+","+lng);
        atualizaEndereco(end, model.get_Endereco(lat, lng));
    }

    public Button getJsonFileButton(TableView<Dados> tabela, PieChart pizza, BarChart barra, ArrayList<Label> frases, Stage stage) {
        FileChooser fc = new FileChooser();
        Button btn = new Button("Buscar em arquivo");
        btn.setFont(new Font("Arial", 14));
        btn.setOnAction((ActionEvent event) -> {
            ObservableList<Dados> observable = FXCollections.observableArrayList();
            File file = fc.showOpenDialog(stage);
            if (file != null) {
                model.obterDadosArquivo(file).forEach((d) -> {
                    observable.add(d);
                });
                tabela.setItems(observable);
                atualiza_Textos(frases);
                atualiza_grafico_pizza(pizza);
                atualiza_grafico_em_barras(barra);
            }
        });
        return btn;
    }

    public Button get_busca_todos_onibus(TableView<Dados> tabela, PieChart pizza, BarChart barra, ArrayList<Label> frases) {
        Button btn = new Button("Buscar todas linhas");
        btn.setFont(new Font("Arial", 14)); 
        Optional<String> result = Optional.empty();
        btn.setOnAction((ActionEvent event) -> {
            metodo(tabela,pizza,barra,frases, result, 1);
        });
        return btn;
    }
    
    public Button get_busca_linha(TableView<Dados> tabela, PieChart pizza, BarChart barra, ArrayList<Label> frases) {
        Button btn = new Button("Buscar linha");
        btn.setFont(new Font("Arial", 14));
        btn.setOnAction((ActionEvent event) -> {
            TextInputDialog dialog = new TextInputDialog();
            dialog.setTitle("Buscar linha");
            dialog.setHeaderText("Informe a linha desejada.\nPara várias linhas, separe-as por virgula.\nEx.: 434 ou 415,426,434");
            dialog.setContentText("Digite a(s) linha(s):");
            Optional<String> result = dialog.showAndWait();
            if (result.isPresent()) {
                metodo(tabela,pizza,barra,frases, result, 2);
            }
        });
        return btn;
    }

    public Button get_busca_Onibus(TableView<Dados> tabela, PieChart pizza, BarChart barra, ArrayList<Label> frases) {
        Button btn = new Button("Buscar ônibus");
        btn.setFont(new Font("Arial", 14));
        btn.setOnAction((ActionEvent event) -> {
            TextInputDialog dialog = new TextInputDialog();
            dialog.setTitle("Buscar onibus");
            dialog.setHeaderText(null);
            dialog.setContentText("Digite a ordem do ônibus:");
            Optional<String> result = dialog.showAndWait();
            if (result.isPresent()) {
                metodo(tabela,pizza,barra,frases, result, 3);
            }
        });
        return btn;
    }

    private ArrayList<Dados> dados_do_Onibus(String ordem) {
        return model.obterDados("http://dadosabertos.rio.rj.gov.br/apiTransporte/apresentacao/rest/index.cfm/obterPosicoesDoOnibus/" + ordem);
    }
    private ArrayList<Dados> dados_da_Linha(String linha) {
        return model.obterDados("http://dadosabertos.rio.rj.gov.br/apiTransporte/apresentacao/rest/index.cfm/obterPosicoesDaLinha/" + linha);
    }
    private ArrayList<Dados> dados_de_todos_onibus() {
        return model.obterDados("http://dadosabertos.rio.rj.gov.br/apiTransporte/apresentacao/rest/index.cfm/obterTodasPosicoes");
    }
}
