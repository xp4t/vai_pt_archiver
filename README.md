Vitis-AI Evaluation Kit - Individual Test Archiver

This repository contains a bash script to compile and package individual inference test suites for various Xilinx Evaluation Kits (e.g., ZCU104, ZCU102, etc.).

The Problem

When following the manual scripts provided in the Xilinx Vitis-AI Tutorials for PyTorch ResNet18 (from the Xilinx/Vitis-AI-Tutorials/PyTorch-ResNet18 GitHub repository), the standard process does not create a complete, successful archive.

Specifically, the default scripts fail to properly package the required test images and the compiled xmodel into a single, deployable file. This makes it difficult to transfer and run the inference tests on a target board.

The Solution

This script automates the entire compilation and archiving process. It correctly gathers all necessary components—including the compiled xmodel and all required test images—and packages them into separate, self-contained .tar archives, one for each specified evaluation kit.

This allows you to just grab the single .tar file for your specific board, copy it, and run inference immediately without missing files.

Features

Multi-Kit Compilation: Runs the compilation process for multiple Xilinx evaluation kits.

Automatic Archiving: Creates a complete, self-contained .tar file for each board.

Includes All Dependencies: Each archive contains the compiled model, test scripts, and the necessary test images to run a successful inference test.

Clean & Portable: No need to clone entire repositories onto your evaluation kit. Just one file.

Prerequisites

A Linux host machine with the Xilinx Vitis-AI development environment and tools (like Vitis, Vivado, etc.) properly installed and sourced.

The necessary source models and files that your script needs to compile.

How to Use

1. On Your Host Machine (Compilation)

Clone this repository:

git clone [Your-Repo-URL]
cd [repository-name]


Make the script executable:

# (Replace with your actual script name)
chmod +x [your_script_name.sh]


Run the script:

./[your_script_name.sh]


Find Your Archives:
Once the script finishes, you will find the .tar files inside the build/ directory.

build/
├── target_zcu104.tar
├── target_zcu102.tar
├── target_vck190.tar
├── target_vek280.tar
├── target_vck5000.tar
└── target_v70.tar


2. On Your Target Evaluation Kit (Inference)

Identify the archive for your board (e.g., target_zcu104.tar).

Copy the archive to your evaluation kit using scp, an SD card, or any other method.

# Example using scp
scp ./build/target_zcu104.tar root@[YOUR_BOARD_IP]:/home/root/


Log in to your board via SSH:

ssh root@[YOUR_BOARD_IP]


Unpack the archive:
(The archive will contain a directory like target_zcu104)

tar -xvf target_zcu104.tar
cd target_zcu104


Run Inference!
You can now run the included test scripts.

# (This command is an example, update it with your script's actual command)
./run_inference.sh


Supported Boards

This script is configured to build for the following evaluation kits:

ZCU104

ZCU102

VCK190

VEK280

VCK5000

V70

Contributing

Feel free to fork this repository, make improvements, and submit a pull request.

License

(I recommend adding a license. MIT is a good, simple choice for utility scripts.)
