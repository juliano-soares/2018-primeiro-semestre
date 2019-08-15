import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.scene.layout.HBox;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.Button;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.ChoiceBox;

import javafx.scene.control.TextField;

public class TableViewExample5 extends Application {
  
  public class DataEntry {
    private SimpleStringProperty primeiro;
    private SimpleStringProperty segundo;
    private SimpleStringProperty terceiro;
    
    private DataEntry(String f, String s, String t) {
      this.primeiro = new SimpleStringProperty(f);
      this.segundo = new SimpleStringProperty(s);
      this.terceiro = new SimpleStringProperty(t);
    }
    // PRIMEIRA COLUNA
    public SimpleStringProperty primeiroProperty() {
      return primeiro;
    }
    public String getPrimeiro() {
      return primeiro.get();
    }
    public void setPrimeiro(String f) {
      primeiro.set(f);
    }
    // SEGUNDA COLUNA 
    public SimpleStringProperty segundoProperty() {
      return segundo;
    }
    public String getSegundo() {
      return segundo.get();
    }
    public void setSegundo(String s) {
      segundo.set(s);
    }
    // TERCEIRA COLUNA
    public SimpleStringProperty terceiroProperty() {
      return terceiro;
    }
    public String getTerceiro() {
      return terceiro.get();
    }
    public void setTerceiro(String t) {
      terceiro.set(t);
    }
  }

  
  private ObservableList<DataEntry> data =
    FXCollections.observableArrayList();
  
  @Override
  public void start(Stage stage) {
    Label label = new Label("Blocos Minecraft");

    TableView<DataEntry> table = new TableView<DataEntry>();
    TableColumn<DataEntry,String> pri_Col = new TableColumn<DataEntry,String>("Nome");
    TableColumn<DataEntry,String> seg_Col = new TableColumn<DataEntry,String>("Transparência");
    TableColumn<DataEntry,String> ter_Col = new TableColumn<DataEntry,String>("Resistência a Explosão");
    table.getColumns().addAll(pri_Col,seg_Col,ter_Col);

    pri_Col.setCellValueFactory(
      new PropertyValueFactory<DataEntry,String>("primeiro"));
    seg_Col.setCellValueFactory(
      new PropertyValueFactory<DataEntry,String>("segundo"));
    ter_Col.setCellValueFactory(
      new PropertyValueFactory<DataEntry,String>("terceiro"));
    
    table.setItems(data);
    String caracteres="0987654321";
    TextField nomefld = new TextField();
    TextField transpfld = new TextField();
    TextField resistfld = new TextField();
    ChoiceBox escolha = new ChoiceBox(FXCollections.observableArrayList(
    "Sim", "Não"));
    escolha.setValue("Sim");
    
    Button btnAdd = new Button("Add");
    btnAdd.setOnAction(ev -> {
      data.add(new DataEntry(nomefld.getText(), escolha.getValue().toString(),resistfld.getText()));
    });
    
    
    Button btnDel = new Button("Del");
    btnDel.setOnAction(ev -> {
      int selectedIndex = table.getSelectionModel().getSelectedIndex();
      if (selectedIndex >= 0 && selectedIndex < data.size()) {
         System.out.println("Removing "+selectedIndex);
         data.remove(selectedIndex);
      } else {
        System.out.println("Selected:"+selectedIndex);
      }
    });
    
    // Quando uma linha da tabela é selecionada,
    // atualiza textfield com dado da segunda coluna
    table.getSelectionModel().selectedItemProperty().addListener((obs, oldSel, newSel) -> {
      if (newSel != null) {
        DataEntry selectedItem = (DataEntry) table.getSelectionModel().getSelectedItem();
        nomefld.setText(selectedItem.getPrimeiro());
        transpfld.setText(selectedItem.getSegundo());
        resistfld.setText(selectedItem.getTerceiro());
      }
    });
    
    Button btnSave = new Button("Save");
    btnSave.setOnAction(ev -> {
      DataEntry selectedItem = (DataEntry) table.getSelectionModel().getSelectedItem();
      selectedItem.setPrimeiro(nomefld.getText());
      selectedItem.setSegundo(transpfld.getText());
      selectedItem.setTerceiro(resistfld.getText());
    }); // E se nenhuma linha estiver selecionada?
    
    Label nome = new Label("Nome");
    Label rest = new Label("Resistência a Explosão");
    Label transp = new Label("Transparência");
    
    HBox hbox = new HBox();
    hbox.getChildren().addAll(btnAdd, btnDel, btnSave);
    
    VBox vbox = new VBox();
    vbox.setSpacing(5);
    vbox.setPadding(new Insets(10, 10, 10, 10));
    vbox.getChildren().addAll(label, table, nome, nomefld, transp, escolha,rest, resistfld, hbox);

    stage.setScene(new Scene(vbox, 400,400));
    stage.show();
  }
  
  
  public static void main(String[] args) {
    launch(args);
  }
}
