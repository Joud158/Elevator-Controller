# 🚀 Elevator Controller – Verilog FSM Project

A Verilog-based **Finite State Machine (FSM)** project that simulates an elevator controller for a three-story building, designed as part of the EECE 320: Digital Systems Design course at the American University of Beirut.

---

## 📘 Project Info

- **Course:** EECE 320 – Digital Systems Design  
- **Institution:** American University of Beirut  
- **Instructor:** Prof. Mazen Saghir  
- **Contributors:**  
  - Ali Rida Awad 
  - Joud Senan

---

## 🛠️ Features

- Moore FSM implementation
- Responds to both floor and cabin requests
- Supports real-life elevator behavior:
  - Idle state handling
  - Single and multiple requests
  - Prioritization based on direction
  - Opening/closing door on request completion
- Direction-aware scheduling of requests
- Proper FSM reset behavior
- Request vector tracking and clearing

---

## 🔧 Inputs

- `clk`: Clock signal  
- `rst`: Active-high asynchronous reset  
- `f_req[3:0]`: Requests from each floor (outside elevator)  
- `c_req[3:0]`: Requests from elevator cabin (inside)

---

## 💡 Outputs

- `request[3:0]`: Current pending floor requests  
- `current_floor[1:0]`: Current elevator floor  
- `direction`: Current direction (1: up, 0: down)  
- `door_open`: Whether the door is currently open (1: yes, 0: no) 

---

## 📈 Design Overview

- **Idle:** No requests; door is closed  
- **Move Up / Move Down:** Elevator moves in direction of nearest requests  
- **Door Open:** Opens door for 1 clock cycle when arriving at a requested floor  
- **Reset:** Returns elevator to ground floor, clears requests, closes doors

### 🔄 Request Handling Strategy
- All requests (cabin + floor) are OR-ed into one vector  
- Requests are served based on direction; flips direction only after exhausting current direction  
- Requests are cleared upon service

---

## 🧪 Testbench

A comprehensive testbench simulates the following scenarios:
- Single floor request
- Multiple requests in one direction
- Requests in opposite directions
- No request (idle state)
- Post-idle state request

Waveforms were validated on [EDA Playground](https://edaplayground.com)

---

## 📂 Files Included

- `design.sv` – Verilog implementation  
- `testbench.sv` – Verilog testbench  
- `Report.pdf` – Project report including state diagram and simulation screenshots  
- `README.md` – This file  

---

## 📄 License

This project was created for educational purposes under the EECE 320 course at AUB. Please cite the original authors when referencing or reusing any part of this work.

---

## 📬 Contact

For questions or contributions:
- Joud Senan – jas53@mail.aub.edu  
- Ali Rida Awad – awa34@mail.aub.edu
