# 無法透過 SSH 登入 EC2 機器的排查    

## 1. 檢查實例狀態 
- 登入 AWS Console，檢查該 EC2 是否狀態為 Running 。
- 檢查 Monitor Dashboard: CloudWatch, Grafana 等，查看該台 EC2 各 Metrics, Healthcheck 等等狀態。  

## 2. 使用 AWS Systems Manager
- 如果該 EC2 是否已啟用 SSM，若有則使用其進行登錄，這樣可以繞過 SSH 進入並檢查 ssh, sshd 等 Config 以及 Service 狀態。

## 3. 查看 EC2 instance console logs  
- 檢查 EC2 的 Console Logs，尋找啟動過程中的錯誤信息，可能會看到服務或配置問題。   

## 4. 考慮重啟 EC2 
- 如果無法找到任何明確原因，考慮重啟並觀察是否恢復正常。   

## 5. 可能原因  
- 錯誤的 `SSHD` 配置導致無法接受連接。(如:不明parameter,錯誤次數鎖定,2FA設定有誤等等)  
- 系統資源耗盡導致無法處理 SSH 請求。  
- 若是使用 SSH 的 Public key 登入檢查是否有被誤刪除。  
- 若是使用 `PEM` 登入檢查該憑證是否有對應同一台 EC2 所使用。   