# 📘 Jenkins → SonarQube Integration (Complete Guide)

### 🔄 Flow

```
GitHub Push → Jenkins Pipeline → SonarQube Analysis → Quality Gate
```


## ✅ Prerequisites

* Jenkins installed and running
* SonarQube installed and accessible
* GitHub repository
* Jenkins plugins installed:

  * Git
  * GitHub
  * Pipeline
  * SonarQube Scanner

---

# 🔵 PART 1: SONARQUBE SETUP (SONARQUBE SIDE)

## 1️⃣ Login to SonarQube

```
http://<SONARQUBE_IP>:9000
```

Default:

* Username: `admin`
* Password: `admin`

---

## 2️⃣ Generate SonarQube Token

```
SonarQube → Administration → Security → Users → Tokens
```

* Name: `jenkins-token`
* Click **Generate**
* ✅ Copy token (used only once)

---

## 3️⃣ Create Project (Optional but Recommended)

```
Projects → Create Project → Manually
```

* Project Key: `amazon-clone`
* Project Name: `Amazon Prime Clone`

---

# 🔵 PART 2: JENKINS GLOBAL CONFIGURATION

## 4️⃣ Add SonarQube Server in Jenkins

```
Jenkins → Manage Jenkins → Configure System
```

### SonarQube servers

* ✔ Enable: **Environment variables**
* Name: `sonarqube`
* Server URL:

  ```
  http://<SONARQUBE_IP>:9000
  ```
* Authentication Token:

  * Add Jenkins credential
  * Kind: **Secret Text**
  * Value: (SonarQube token)

✅ Save

---

## 5️⃣ Configure SonarScanner Tool

```
Jenkins → Manage Jenkins → Global Tool Configuration
```

### SonarQube Scanner

* Name: `SonarScanner`
* ✔ Install automatically
* Version: Latest

⚠️ Name **must match Jenkinsfile exactly**

---

# 🔵 PART 3: GITHUB WEBHOOK (AUTO TRIGGER)

## 6️⃣ Configure Jenkins Job

```
Jenkins → New Item → Pipeline
```

### Build Triggers

✔ **GitHub hook trigger for GITScm polling**

### Pipeline

```
Definition: Pipeline script from SCM
SCM: Git
Repository URL: https://github.com/<username>/<repo>.git
Branch: */main
Script Path: Jenkinsfile
```

---

## 7️⃣ Add GitHub Webhook

```
GitHub Repo → Settings → Webhooks → Add webhook
```

* Payload URL:

  ```
  http://<JENKINS_IP>:8080/github-webhook/
  ```
* Content type: `application/json`
* Events: **Push**
* SSL: Disable (for HTTP)

✅ Add webhook
Webhook delivery must show **200 OK**

---


# 🔵 PART 4: TESTING & VERIFICATION

## 🔁 Manual Test

* Jenkins → Job → **Build Now**
* Must pass without errors

## 🔁 Auto Trigger Test

```bash
git commit --allow-empty -m "test sonar webhook"
git push origin main
```

✅ Jenkins job should start automatically
✅ SonarQube project should show analysis

---
