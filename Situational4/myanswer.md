# 將日誌檔內容串接至 ELK/EFK 系統的流程   
## 先說明我目前的使用情境 Filebeat>Logstash>AWS Opensearch

## 1. 確認送進 Filebeat 的日誌格式  
- 確保新服務的日誌格式符合系統的要求，通常使用 JSON 格式會更容易解析。  
- 包括時間戳、日誌級別、服務名稱、請求ID等關鍵字段，確保日誌的一致性和可讀性。  

## 2. 設定 Logstash  
- 編寫 Logstash 的配置文件，設置 input, filter, output等。(如mutate 調整不必要欄位,若有需要也可以依據 `Log Level` 發送對應的通到 Slack )  
- 評估 Logstash 以及 OpenSearch 集群的資源判斷一次收送的封包大小

## 3. 設定 Opensearch 
- 設定 Index Pattren 至各自不同的 Tenant 若有需要的話。
- 確定各 Index 送上來的 Feilds 是否符合上一步驟 Logstash 的設定。
- 後續補上 Index Policy 讓 Index 可以用 LifeCycle 的機制為了確保集群資源的穩定性。