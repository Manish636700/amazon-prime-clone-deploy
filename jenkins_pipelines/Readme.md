### ✅ Step 1: Jenkins Credentials

Create these in **Jenkins → Manage Credentials**:

| Credential     | Type        | ID               |
| -------------- | ----------- | ---------------- |
| AWS Access Key | Secret Text | `aws-access-key` |
| AWS Secret Key | Secret Text | `aws-secret-key` |
| Sonar Token    | Secret Text | `sonar-token`    |
| Sonar Host URL | Secret Text | `sonar-host-url` |


### ✅ Step 2: Install Git

```bash
sudo yum install git -y
```

### 🔹 Verify Git installation

```bash
git --version
```


## 🔄 Restart Jenkins (IMPORTANT)

After installing Git:

```bash
sudo systemctl restart jenkins
```


## ✅ Step 3 Use Jenkins SonarQube Plugin

### 1️⃣ Install plugins (if not installed)

* **SonarQube Scanner**
* **SonarQube**

---

### 2️⃣ Configure Jenkins (One-time)

**Manage Jenkins → System → SonarQube Servers**

* Name: `sonarqube`
* URL: `http://<sonar-ip>:9000`
* Token: `sonar-token`

**Manage Jenkins → Tools → SonarQube Scanner**

* Name: `sonar-scanner`
* Check **Install automatically**

---

### 🔗 Configure SonarQube Webhook

In **SonarQube UI**:

```
Administration → Configuration → Webhooks → Create
```

**Fill this exactly:**

* **Name:** Jenkins

* **URL:**

  ```
  http://<JENKINS_URL>/sonarqube-webhook/
  ```

  Example:

  ```
  http://52.66.xx.xx:8080/sonarqube-webhook/
  ```

* **Secret:** (leave empty)

* Save

---

