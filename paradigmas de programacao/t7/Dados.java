package javaapplication5;
import java.util.List;
import javafx.beans.property.SimpleStringProperty;
public class Dados {
    private final SimpleStringProperty data;       
    private final SimpleStringProperty ordem;      
    private final SimpleStringProperty linha;      
    private final SimpleStringProperty latitude;   
    private final SimpleStringProperty longitude;  
    private final SimpleStringProperty velocidade; 
    private static final int DATAHORA = 0;
    private static final int ORDEM = 1;
    private static final int LINHA = 2;
    private static final int LATITUDE = 3;
    private static final int LONGITUDE = 4;
    private static final int VELOCIDADE = 5;
/**********************************************************************************************/
    // construtor de dado
    public Dados(List dado) {
        this.data = new SimpleStringProperty((String)dado.get(DATAHORA));
        this.ordem = new SimpleStringProperty((String)dado.get(ORDEM));
        this.linha = new SimpleStringProperty(String.valueOf(dado.get(LINHA)));
        this.latitude = new SimpleStringProperty(String.valueOf(dado.get(LATITUDE)));
        this.longitude = new SimpleStringProperty(String.valueOf(dado.get(LONGITUDE)));
        this.velocidade = new SimpleStringProperty(String.valueOf(dado.get(VELOCIDADE)));
    }    
/**********************************************************************************************/
    // Ordem
    public SimpleStringProperty ordemProperty() {
        return ordem;
    }
    public String get_Ordem() {
        return ordem.get();
    }
    public void set_Ordem(String ordem) {
        this.ordem.set(ordem);
    }
/**********************************************************************************************/
    // DataHora
    public SimpleStringProperty dataProperty() {
        return data;
    }
    public String get_Data() {
        return data.get();
    }
    public void set_Data(String data) {
        this.data.set(data);
    }    
/**********************************************************************************************/
    // Latitude
    public SimpleStringProperty latitudeProperty() {
        return latitude;
    }
    public double getLatitude() {
        return Double.parseDouble(latitude.get());
    }
    public void setLatitude(String latitude) {
        this.latitude.set(latitude);
    }
/**********************************************************************************************/
    // Longitude
    public SimpleStringProperty longitudeProperty() {
        return longitude;
    }
    public double getLongitude() {
        return Double.parseDouble(longitude.get());
    }
    public void setLongitude(String longitude) {
        this.longitude.set(longitude);
    }
/**********************************************************************************************/
    // Linha
    public SimpleStringProperty linhaProperty() {
        return linha;
    }
    public String getLinha() {
        return linha.get();
    }
    public void setLinha(String linha) {
        this.linha.set(linha);
    }
/**********************************************************************************************/
    // Velocidade
    public SimpleStringProperty velocidadeProperty() {
        return velocidade;
    }
    public double getVelocidade() {
        return Double.parseDouble(velocidade.get());
    }
    public void setVelocidade(String velocidade) {
        this.velocidade.set(velocidade);
    }
/**********************************************************************************************/    
}
