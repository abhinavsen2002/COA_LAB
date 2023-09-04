OPCODE = {
    "add": 0, "comp": 0,
    "and": 0, "xor": 0,
    "shll": 0, "shrl": 0,
    "shllv": 0, "shrlv": 0,
    "shra": 0, "shrav": 0,
    "addi": 8, "compi": 9,
    "lw": 16, "sw": 24,
    "b": 40, "br": 32,
    "bltz": 48, "bz": 49,
    "bnz": 50, "bl": 43,
    "bcy": 41, "bncy": 42,
    "diff": 0
}

RFORMATS = {
    "add", "comp",
    "and", "xor",
    "shll", "shrl",
    "shllv", "shrlv",
    "shra", "shrav",
    "diff"}

FUNCODE = {
    "add": 1, "comp": 5,
    "and": 2, "xor": 3,
    "shll": 12, "shrl": 14,
    "shllv": 8, "shrlv": 10,
    "shra": 15, "shrav": 11,
    "diff": 6
}

import sys
import regex as re
import argparse
import os


# Global variables
LTABLE = {}  # Label table (key: label, value: address)
LABEL_RE = re.compile(r'^\s*\.?(?P<label>\w+):\s*$')  # Label regex
PC = 0  # program counter


def parse_labels(source_file):
    """
        Parses the source file to find all labels and stores them in LTABLE
    """
    global PC
    with open(source_file, 'r') as f:
        for line in f:
            line = line.strip()
            if line == '' or line[0] == '#':
                continue
            m = LABEL_RE.match(line)
            if m:
                label = m.group('label')
                if label in LTABLE:
                    raise Exception('Error: Label {} already defined at Line: {}'.format(label, LTABLE[label]))
                else:
                    LTABLE[label] = PC
            else:
                PC = PC + 4
    PC = 0


def main(source_file, output_file):
    global PC
    instructs = []
    with open(source_file, 'r') as f:
        for lno, line in enumerate(f.readlines()):
            line = line.strip()
            if line == '' or line[0] == '#':
                # print('Skipping line: {}'.format(line))
                continue
            elif LABEL_RE.match(line):
                label = LABEL_RE.match(line).group('label')
                if label not in LTABLE:
                    raise Exception('Error: Label {} not defined at Line: {}'.format(
                        label, lno))
                continue
            else:
                args = re.split(r'[\s,\(\)]+', line)
                op = args[0]
                if op in RFORMATS:  # r-format instructions
                    opcode = OPCODE[op]
                    funct = FUNCODE[op]
                    rs, rt = args[1], args[2]
                    shamt = 0
                    if rs[0] != "$":
                        raise Exception('Invalid register {}'.format(rs))
                    rs = int(rs[1:])
                    if rt[0] != "$":
                        shamt = int(rt) & 0b11111  # shamt is 5 bits
                        rt = 0  # can be kept garbage also
                    else:
                        rt = int(rt[1:])
                    instr = opcode << 26 | rs << 21 | rt << 16 | shamt << 11 | funct << 5
                    instr = format(instr, '032b')
                    instructs.append(instr)

                elif op == "lw" or op == "sw":  # lw and sw instructions
                    opcode = OPCODE[op]
                    rt, imm, rs = args[1], args[2], args[3]
                    if rs[0] != "$":
                        raise Exception('Invalid register {}'.format(rs))
                    rs = int(rs[1:])
                    if rt[0] != "$":
                        raise Exception('Invalid register {}'.format(rt))
                    rt = int(rt[1:])
                    imm = int(imm)
                    imm = bin(imm & 0xFFFF)  # 16 bit (2's complement)
                    imm = int(imm, 2)
                    instr = opcode << 26 | rs << 21 | rt << 16 | imm
                    instr = format(instr, '032b')
                    instructs.append(instr)

                elif op == "addi" or op == "compi":
                    opcode = OPCODE[op]
                    rs, imm = args[1], args[2]
                    if rs[0] != "$":
                        raise Exception('Invalid register {}'.format(rs))
                    rs = int(rs[1:])
                    imm = int(imm)
                    imm = bin(imm & 0xFFFF)  # 16 bit (2's complement)
                    imm = int(imm, 2)
                    instr = opcode << 26 | rs << 21 | imm
                    instr = format(instr, '032b')
                    instructs.append(instr)

                elif op in ["b", "bcy", "bncy", "bl"]:
                    opcode = OPCODE[op]
                    label = args[1]
                    if label in LTABLE:
                        # pseudo-direct addressing
                        addr = LTABLE[label]
                        addr = format(addr, '032b')
                        instr = opcode << 26 | int(addr[3:-2], 2)
                        instr = format(instr, '032b')
                        instructs.append(instr)
                    else:
                        raise Exception("Error: Label {} not defined at Line: {}".format(label, lno))
                elif op == "br":
                    opcode = OPCODE[op]
                    rs = args[1]
                    if rs[0] != "$":
                        raise Exception('Invalid register {}'.format(rs))
                    rs = int(rs[1:])

                    instr = opcode << 26 | rs << 21
                    instr = format(instr, '032b')

                    instructs.append(instr)

                elif op in ["bltz", "bz", "bnz"]:
                    opcode = OPCODE[op]
                    rs, label = args[1], args[2]
                    if rs[0] != "$":
                        raise Exception('Invalid register {}'.format(rs))
                    rs = int(rs[1:])

                    if label in LTABLE:
                        addr = LTABLE[label] - PC - 4
                        addr = (addr >> 2) & 0xFFFF
                        instr = opcode << 26 | rs << 21 | addr
                        instr = format(instr, '032b')
                        instructs.append(instr)

                    else:
                        raise Exception(
                            "Error: Label {} not defined at Line: {}".format(label, lno))
                else:
                    raise Exception('Error: Invalid instruction {}'.format(op))

                PC = PC + 4
    with open(output_file, 'w') as f:
        f.write("memory_initialization_radix=2;\nmemory_initialization_vector=")
        for i in range(len(instructs) - 1):
            f.write('\n'+instructs[i]+',')
        f.write('\n' + instructs[-1] + ';')


def replace_in_asm(source_file):
    dict = {"$v0": "$2", "$v1": "$3", "$a0": "$4", "$a1": "$5", "$a2": "$6", "$a3": "$7", "$t0": "$8", "$t1": "$9","$t2": "$10", "$t3": "$11", "$t4": "$12", "$t5": "$13", "$t6": "$14", "$t7": "$15", "$s0": "$16", "$s1": "$17", "$s2": "$18", "$s3": "$19", "$s4": "$20", "$s5": "$21", "$s6": "$22", "$s7": "$23", "$t8": "$24", "$t9": "$25", "$gp": "$28", "$sp": "$29", "$fp": "$30", "$ra": "$31"}
    with open(source_file, 'r') as f:
        lines = f.readlines()
    with open(source_file, 'w') as f:
        for line in lines:
            for key, value in dict.items():
                line = line.replace(key, value)
            f.write(line)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='KGP-RISC assembler')
    parser.add_argument('-s', '--source', help='source file', required=True, type=str)
    parser.add_argument('-o', '--output', help='output file', default='prog.coe', type=str)
    args = parser.parse_args()

    # Check if source file exists
    if not os.path.isfile(args.source):
        print('Error: source file does not exist')
        sys.exit(1)

    parse_labels(args.source)
    replace_in_asm(args.source)
    main(args.source, args.output)