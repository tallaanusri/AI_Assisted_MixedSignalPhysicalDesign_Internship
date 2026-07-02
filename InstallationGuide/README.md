
# Complete Installation Guide (Windows)

**Recommended:** Use **Ubuntu via WSL2** (Windows Subsystem for Linux). It's the officially recommended setup for OpenLane.

### Step 1: Install WSL2

Open **PowerShell as Administrator** and run:

```powershell
wsl --install
```

Restart your PC.

---

### Step 2: Install Ubuntu

Open the Microsoft Store.

Install

```
Ubuntu 22.04 LTS
```

Launch Ubuntu and create your username/password.

---

### Step 3: Update Ubuntu

```bash
sudo apt update
sudo apt upgrade -y
```

---

### Step 4: Install Docker

```bash
sudo apt install docker.io -y
```

Check the installation:

```bash
docker --version
```

Expected output:

```
Docker version xx.xx.xx
```

---

### Step 5: Enable Docker

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Add your user to the Docker group:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in.

Verify:

```bash
docker run hello-world
```

If you see the "Hello from Docker!" message, Docker is working.

---

### Step 6: Install Git

```bash
sudo apt install git -y
```

Verify:

```bash
git --version
```

---

### Step 7: Clone OpenLane

```bash
git clone https://github.com/The-OpenROAD-Project/OpenLane.git
```

Go into the directory:

```bash
cd OpenLane
```

---

### Step 8: Build the Docker Image

```bash
make
```

This downloads the required Docker image.

---

### Step 9: Install the SKY130 PDK

Run:

```bash
make pdk
```

This downloads the SKY130 Process Design Kit.

---

### Step 10: Start OpenLane

```bash
make mount
```

You should enter the OpenLane Docker environment:

```text
OpenLane Container
```

Now you can run ASIC designs.

---
