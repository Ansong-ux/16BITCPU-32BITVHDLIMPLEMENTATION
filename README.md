<div align="center">

<img src="https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-10-45.png" width="100%" alt="Full CPU Schematic"/>

<br/>

```
  ██████╗██████╗ ███████╗███╗   ██╗    ██████╗   ██╗ ███████╗
 ██╔════╝██╔══██╗██╔════╝████╗  ██║    ╚════██╗ ╚██╗ ██╔════╝
 ██║     ██████╔╝█████╗  ██╔██╗ ██║     █████╔╝  ██║ ███████╗
 ██║     ██╔═══╝ ██╔══╝  ██║╚██╗██║        ██    ██║ ╚════██║
 ╚██████╗██║     ███████╗██║ ╚████║    ███████╗  ██  ███████║
  ╚═════╝╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚══════╝╚═╝   ╚══════╝
```

# 16-Bit CPU & 32-Bit MIPS Processor

**CPEN 315 — Computer Organization & Architecture**  
University of Ghana · 2025/2026

**Authors:** Sasu Thomas Ansong · Sherrif Akparibo Issakah

</div>

---

## 📌 Project Overview

A two-part CPU design project pushing from gate-level simulation to full hardware description:

| | Part A | Part B |
|---|---|---|
| **What** | 16-bit CPU | 32-bit single-cycle MIPS processor |
| **Tool** | Logisim Evolution | VHDL (ModelSim / Vivado) |
| **Scope** | ALU · Registers · Datapath · CU · RAM · 7-seg display | Data Memory · ALU · ALU Control · Register File · Instruction Memory · CPU Control |

---

## Part A — 16-Bit CPU in Logisim Evolution

### Architecture at a Glance

| Component | Width | Description |
|-----------|-------|-------------|
| Register A / B | 16-bit | Operand storage |
| ALU | 16-bit | Arithmetic + relational operations |
| Output Register | 16-bit | Holds ALU result |
| Instruction Register (IR) | 16-bit | 8-bit opcode + 8-bit address |
| Memory Buffer Register (MBR) | 16-bit | Buffers data to/from RAM |
| Memory Address Register (MAR) | 8-bit | Holds RAM address |
| Program Counter (PC) | 4-bit | Cycles `0000`→`0011`, wraps |

---

### 🔬 Circuit Diagrams

<details open>
<summary><strong>Arithmetic Operation Unit</strong> <code>project_ao</code></summary>
<br/>

![Arithmetic Operation Circuit](https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-07-55.png)

</details>

<details>
<summary><strong>Relational Operation Unit</strong> <code>project_ro</code></summary>
<br/>

![Relational Operation Circuit](https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-08-26.png)

</details>

<details>
<summary><strong>ALU</strong> <code>project_alu</code></summary>
<br/>

![ALU Circuit](https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-08-50.png)

</details>

<details>
<summary><strong>Datapath</strong></summary>
<br/>

![Datapath](https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-09-56.png)

</details>

<details>
<summary><strong>Decimal Decoder</strong></summary>
<br/>

![Decimal Decoder](https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-10-21.png)

</details>

<details>
<summary><strong>Control Unit (CU)</strong></summary>
<br/>

![Control Unit](https://raw.githubusercontent.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/ce84643d149db9db344832316863a577e2b365fc/Screenshot_2026-04-03_02-11-23.png)

</details>

---

### ⚙️ ALU Operation Set

#### Arithmetic (AUSel — 4-bit selector)

| Sel | Operation | Sel | Operation |
|-----|-----------|-----|-----------|
| `0` | `A + B` | `7` | `A - B` |
| `1` | `A & B` | `8` | `A << 2` |
| `2` | `A \| B` | `9` | `B << 2` |
| `3` | `A ^ B` | `10` | `A >> 2` |
| `4` | `A / B` | `11` | `B >> 2` |
| `5` | `A % B` | `12` | `-A` (2's complement) |
| `6` | `A * B` | `13` | `-B` (2's complement) |

#### Relational (RUSel — 3-bit selector)

| Sel | Operation | Sel | Operation |
|-----|-----------|-----|-----------|
| `0` | `A > B` | `3` | `A < B` |
| `1` | `A == B` | `4` | `A <= B` |
| `2` | `A >= B` | `5` | `A != B` |

---

### 🧠 Instruction Set & RAM Layout

#### Opcodes

| Opcode | Instruction |
|--------|-------------|
| `00000000` | `LoadA` |
| `00000001` | `LoadB` |
| `00000010` | `Arithmetic` |
| `00000011` | `Store` |

#### RAM Contents (16-address · 16-bit wide · 8-bit address)

| Address (bin) | Hex | Contents | Note |
|---------------|-----|----------|------|
| `0000` | `0x00` | `0x000A` | `LoadA` — load from addr 10 |
| `0001` | `0x01` | `0x010D` | `LoadB` — load from addr 13 |
| `0010` | `0x02` | `0x0200` | `Arithmetic` (ADD) |
| `0011` | `0x03` | `0x030A` | `Store` result → addr 10 |
| `1010` | `0x0A` | `0x000A` | Operand A = 10 |
| `1101` | `0x0D` | `0x000F` | Operand B = 15 |

---

### 🕹️ Control Unit — Micro-Operation Signals (C0–C15)

<details>
<summary><strong>LoadA</strong> — Opcode <code>00000000</code> · 6 clock steps</summary>
<br/>

| Step | C0 | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | C11 | C12 | C13 | C14 | C15 |
|------|----|----|----|----|----|----|----|----|----|----|-----|-----|-----|-----|-----|-----|
| 000 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 001 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 010 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 011 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 100 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 101 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |

</details>

<details>
<summary><strong>LoadB</strong> — Opcode <code>00000001</code> · 6 clock steps</summary>
<br/>

| Step | C0 | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | C11 | C12 | C13 | C14 | C15 |
|------|----|----|----|----|----|----|----|----|----|----|-----|-----|-----|-----|-----|-----|
| 000 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 001 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 010 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 011 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 100 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 101 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |

</details>

<details>
<summary><strong>Arithmetic</strong> — Opcode <code>00000010</code> · 4 clock steps</summary>
<br/>

| Step | C0 | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | C11 | C12 | C13 | C14 | C15 |
|------|----|----|----|----|----|----|----|----|----|----|-----|-----|-----|-----|-----|-----|
| 000 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 001 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 010 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 011 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 |

</details>

<details>
<summary><strong>Store</strong> — Opcode <code>00000011</code> · 5 clock steps</summary>
<br/>

| Step | C0 | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | C11 | C12 | C13 | C14 | C15 |
|------|----|----|----|----|----|----|----|----|----|----|-----|-----|-----|-----|-----|-----|
| 000 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 001 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 010 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 011 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| 100 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |

</details>

---

## Part B — 32-Bit MIPS Processor in VHDL

### Instruction Formats

| Format | Fields | Purpose |
|--------|--------|---------|
| **R-format** | `op[2:0]` · `rs[2:0]` · `rt[2:0]` · `rd[2:0]` · `funct[3:0]` | Arithmetic (register–register) |
| **I-format** | `op[2:0]` · `rs[2:0]` · `rt[2:0]` · `imm[6:0]` | Load/Store · Branch · Immediate |
| **J-format** | `op[2:0]` · `target[12:0]` | Jump |

### VHDL Component Map

| File | Entity | Key Interface |
|------|--------|---------------|
| `ALU_VHDL.vhd` | `ALU_VHDL` | `a[31:0]`, `b[31:0]`, `alu_control[2:0]` → `alu_result[31:0]`, `zero` |
| `ALU_Control_VHDL.vhd` | `ALU_Control_VHDL` | `ALUOp[1:0]`, `ALU_Funct[2:0]` → `ALU_Control[2:0]` |
| `Register_File_VHDL.vhd` | `Register_File_VHDL` | 8 × 32-bit registers · sync write · async read |
| `Data_Memory_VHDL.vhd` | `Data_Memory_VHDL` | `mem_access_addr[31:0]`, `mem_write_en`, `mem_read` → `mem_read_data[31:0]` |
| `Instruction_Memory_VHDL.vhd` | `Instruction_Memory_VHDL` | `pc[31:0]` → `instruction[31:0]` |
| `CPU_Control_VHDL.vhd` | `CPU_Control_VHDL` | `opcode[2:0]` → 10 control signals |

### Supported MIPS Instructions

| Instruction | Type | Operation |
|-------------|------|-----------|
| `add` | R | `R[rd] = R[rs] + R[rt]` |
| `sub` | R | `R[rd] = R[rs] - R[rt]` |
| `and` | R | `R[rd] = R[rs] & R[rt]` |
| `or` | R | `R[rd] = R[rs] \| R[rt]` |
| `slt` | R | `R[rd] = (R[rs] < R[rt]) ? 1 : 0` |
| `jr` | R | `PC = R[rs]` |
| `lw` | I | `R[rt] = M[R[rs] + SignExtImm]` |
| `sw` | I | `M[R[rs] + SignExtImm] = R[rt]` |
| `beq` | I | `if (R[rs]==R[rt]) PC = PC+4+BranchAddr` |
| `addi` | I | `R[rt] = R[rs] + SignExtImm` |
| `slti` | I | `R[rt] = (R[rs] < imm) ? 1 : 0` |
| `j` | J | `PC = JumpAddr` |
| `jal` | J | `R[7] = PC+4; PC = JumpAddr` |

---

### 📊 Simulation Waveforms

<details open>
<summary><strong>ALU Waveform</strong></summary>
<br/>

![ALU Waveform](https://github.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/blob/ce84643d149db9db344832316863a577e2b365fc/task2_alu_sim.png)

</details>

<details>
<summary><strong>Control Unit Waveform</strong></summary>
<br/>

![Control Unit Waveform](https://github.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/blob/ce84643d149db9db344832316863a577e2b365fc/ask5_control_unit_sim.png)

</details>

<details>
<summary><strong>Data Memory Waveform</strong></summary>
<br/>

![Data Memory Waveform](https://github.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/blob/ce84643d149db9db344832316863a577e2b365fc/task1_data_memory_sim.png)

</details>

<details>
<summary><strong>Register File Waveform</strong></summary>
<br/>

![Register File Waveform](https://github.com/Ansong-ux/16BITCPU-32BITVHDLIMPLEMENTATION/blob/ce84643d149db9db344832316863a577e2b365fc/task3_register_file_sim.png)

</details>

---



---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| **Logisim Evolution** | 16-bit CPU schematic & simulation |
| **VHDL** | Hardware description language for Part B |
| **https://www.edaplayground.com// Vivado** | VHDL simulation & waveform analysis |
| **GitHub** | Version control & team collaboration |

---

## 🔭 Future Development

- [ ] Top-level integration of all VHDL components into a single 32-bit MIPS entity
- [ ] FPGA deployment via Quartus or Vivado
- [ ] Extension to a full **pipelined** MIPS architecture (5-stage)
- [ ] Hazard detection and forwarding unit

---

<div align="center">

*CPEN 315 — Computer Organization & Architecture*  
*University of Ghana · 2025/2026*

**Sasu Thomas Ansong · Sherrif Akparibo Issakah**

</div>
