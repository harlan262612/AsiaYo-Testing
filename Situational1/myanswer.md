# 推廣期間高流量處理計劃  

## 1. Pod 自動擴展  
- 使用 Kubernetes 的 HPA 機制，根據平常流量倍數判定何時自動水平擴展。  
- 確保 Pod 內部的 Resource Requests 和 Limits 設定正確，以便擴展到自身機型可負荷的範圍。  

## 2. Node 自動擴展  
- 利用 AWS 原生的 Autoscaling Group，使用 Prometheus Node Exporter 拋出的 metrics（如 Memory、Disk等等）來監控。   
- 最終將這些指標打到 Slack，以 ChatOps 的形式由 SRE 團隊確認後，進行機器數量的增長與縮減。  
- 會使用 Slack 的 Chatops 是因為考慮到 Billing 因素，我覺得需保留SRE 人工審核的步驟。  

## 3. Load Balancer 和 Deployment 配置  
- 確保 Load Balancer 以及 Deployment 上的 Affinity 或 Selector 設定正確，並且流量能平均分配到各台 Node 上。  

## 4. 緩存機制  
- 利用 CDN 將部分靜態圖檔或文案進行緩存，以減輕伺服器的負擔。  
- 將一些後端即時訪問的參數存成 Redis 的 key，以降低後方數據庫的效能負擔。  

## 5. 壓測與回滾計劃  
- 定期進行壓力測試，模擬高流量的 SOP 運行，確保系統的穩定性。  
- 準備好快速 Rollback 到穩定版本的計劃，以確保此次活動不會出現異常。  
