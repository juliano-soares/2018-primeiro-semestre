package javaapplication5;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

public class Model {
    private final HttpJSONService http = new HttpJSONService();
    private final ArrayList<Dados> dados = new ArrayList<>();
    private String dataUltimaLeitura = "Sem registros";
    public ArrayList<Dados> obterDados(String url) {
        inserir_Dados(getJson(url));
        return dados;
    }
    public ArrayList<Dados> obterDadosArquivo(File file) {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(file));
            inserir_Dados(new JSONParsing().parseJSON(br.readLine()));
        } catch (IOException | ScriptException e1) {
        } finally {
            try {
                if (br != null)
                    br.close();
            } catch (IOException e3) {
            }
        }
        return dados;
    }  
    /// retorna o numero total de veiculos parados
    public int get_Veiculos_Parados() {
        int parados = 0;
        parados = dados.stream().filter((d) -> (d.getVelocidade() == 0.0)).map((_item) -> 1).reduce(parados, Integer::sum);
        return parados;
    } 
    /// retorna o tempo da ultima leitura 
    public String get_Data_Ultima() {
        return dataUltimaLeitura;
    }
    /// retorna o tempo menos recente de leitura
    public String get_Data_antiga() {
        if (dados.isEmpty())
            return "Vazio";
        String antiga = dados.get(0).get_Data();
        for (Dados d : dados) {
            if (dataMenor(d.get_Data(), antiga))
                antiga = d.get_Data();
        }
        return antiga;
    }
    /// retorna numero total de veiculos
    public int get_total_veiculos() {
        return dados.size();
    } 
    /// retorna o tempo mais recente de leitura
    public String get_Data_Nova() {
        if (dados.isEmpty())
            return "Vazia";
        String maisRecente = dados.get(0).get_Data();
        for (Dados d : dados) {
            if (dataMenor(maisRecente, d.get_Data()))
                maisRecente = d.get_Data();
        }
        return maisRecente;
    }
    public int get_Veiculos_movimento_linha(String linha) {
        int emMovimento = 0;
        emMovimento = dados.stream().filter((d) -> (d.getLinha().equals(linha) && d.getVelocidade() != 0.0)).map((_item) -> 1).reduce(emMovimento, Integer::sum);
        return emMovimento;
    }
    public String get_Endereco(double lat, double lng) {
        String url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + lat + "," + lng + "&key=AIzaSyCMzST_dQwc1gbFvxFakpAt_YBAhSu5MuI";
        Map obj = getJson(url);

        if (obj != null) {
            if (obj.get("status") == "OVER_QUERY_LIMIT")
                obj = getJson(url);
            if (obj.get("status") == "OK") {
                List l = (List)obj.get("results");
                return (String)((Map)l.get(0)).get("formatted_address");
            }
        }
        return "Rio de Janeiro - RJ, Brasil";
    }
    public ArrayList<String> get_Linhas() {
        ArrayList<String> linhas = new ArrayList<>();
        dados.stream().filter((d) -> (!linhas.contains(d.getLinha()))).forEachOrdered((d) -> {
            linhas.add(d.getLinha());
        });
        linhas.remove("");
        return linhas;
    }
    private void inserir_Dados(Map obj) {
        if (obj == null) return;
        dados.clear();
        for (Object l : (List)obj.get("DATA"))
            dados.add(new Dados((List)l));
        dataUltimaLeitura = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss").format(Calendar.getInstance().getTime());
    }

    private Map getJson(String url) {
        Map json = null;
        try {
            json = http.sendGet(url);
        } catch (Exception e) {
            System.out.println("\nNao foi possivel conectar.");
            System.out.println("Verifique sua conexao.");
            System.out.println("(" + e + ")");
        }
        return json;
    }

    private Boolean dataMenor(String d1, String d2) {
        SimpleDateFormat format = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
        try {
            if (format.parse(d1).before(format.parse(d2)))
                return true;
        } catch (ParseException e) {
            System.out.println("(" + e + ")");
        }
        return false;
    }
}
/**********************************************************************************************/  
class HttpJSONService {
    private final String USER_AGENT = "Mozilla/5.0";
    private final JSONParsing engine = new JSONParsing();
    public Map sendGet(String url) throws Exception {
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection)obj.openConnection();
        
        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", USER_AGENT);
        
        int responseCode = con.getResponseCode();
        
        System.out.println("\n'GET' request sent to URL : " + url);
        System.out.println("Response Code : " + responseCode);
        
        StringBuilder response;
        try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
            response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
        }

        JSONParsing d;
        d = new JSONParsing();
        return d.parseJSON(response.toString());
    }
}
class JSONParsing {
    private final ScriptEngine engine;
  
    public JSONParsing() {
        ScriptEngineManager sem = new ScriptEngineManager();
        this.engine = sem.getEngineByName("javascript");
    }
  
    public Map parseJSON(String json) throws IOException, ScriptException {
        String script = "Java.asJSONCompatible(" + json + ")";
        Object result = this.engine.eval(script);
        Map contents = (Map)result;
        return contents;
    }
}
