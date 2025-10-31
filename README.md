# Vitis-AI Test Suite Compiler and Archiver

This repository provides a **bash script** that automates the process of compiling and packaging individual inference test suites for various **Xilinx Evaluation Kits** (e.g., ZCU104, ZCU102, VCK190, etc.).

## Problem

When following the manual scripts from the [Xilinx Vitis-AI Tutorials for PyTorch ResNet18](https://github.com/Xilinx/Vitis-AI-Tutorials/tree/3.5/Tutorials/PyTorch-ResNet18/), the default process often fails to generate a **complete and self-contained archive**. In particular:

* The required **test images** and **compiled `.xmodel`** files are not correctly packaged together.
* As a result, transferring and running inference tests on a target board becomes cumbersome and error-prone.

## Solution

This script automates the **entire compilation and packaging process**, ensuring that each evaluation kit receives its own **self-contained `.tar` archive**. Each archive includes everything required to run inference immediately.

### Key Features

* **Multi-Kit Compilation:** Supports compilation for multiple Xilinx evaluation kits in one go.
* **Automatic Archiving:** Creates `.tar` archives for each supported board.
* **Dependency Bundling:** Includes compiled models, test scripts, and test images.
* **Clean & Portable:** Transfer just one archive file to your board — no need to clone or copy large repositories.

## Prerequisites

* A **Linux host machine** with the Xilinx **Vitis-AI development environment** properly installed and sourced.
* Necessary **source models** and **files** available for compilation.

## How to Use

### 1. On Your Host Machine (Compilation)

Clone this repository:

```bash
git clone https://github.com/xp4t/vai_pt_archiver.git
cd vai_pt_archiver
```

Make the script executable:

```bash
chmod +x compile.sh
cp compile.sh ~/Vitis-AI/Tutorials/PyTorch-ResNet18/files/ #this should be your working directory
```

Run the script in Vitis-AI Docker Container:

```bash
bash -x ./compile.sh
```

After completion, find your archives inside the `build/` directory:

```
build/
├── target_zcu104.tar
├── target_zcu102.tar
├── target_vck190.tar
├── target_vek280.tar
├── target_vck5000.tar
└── target_v70.tar
```

---

### 2. On Your Target Evaluation Kit (Inference)

Identify and copy the archive corresponding to your board. Example for **ZCU104**:

```bash
scp target_zcu104.tar root@[YOUR_BOARD_IP]:~/
```

Log in to your board via SSH (OPTIONAL):

```bash
ssh root@[YOUR_BOARD_IP]
```

Unpack the archive:

```bash
tar -xvf target_zcu104.tar
cd target_zcu104
```

Run the included inference test script:

```bash
bash -x ./run_all_target.sh zcu104 #change to your board name
```

---

## Supported Boards

* **ZCU104**
* **ZCU102**
* **VCK190**
* **VEK280**
* **VCK5000**
* **V70**

---

## 🤝 Contributing

Contributions are welcome! Fork this repository, make improvements, and submit a pull request.

---

## 📜 License

This project is licensed under the **MIT License** — simple and permissive for utility scripts.
