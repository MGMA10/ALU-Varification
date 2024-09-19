import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge
import random

pass_count = 0
fail_count = 0

# Clock generation
@cocotb.coroutine
async def generate_clock(dut):
    clock = Clock(dut.clk, 10, units="ns")  # 100MHz clock
    cocotb.fork(clock.start())

@cocotb.coroutine
async def reset(dut):
    dut.rst_n <= 0
    await FallingEdge(dut.clk)
    dut.rst_n <= 1
    await FallingEdge(dut.clk)

# Test addition operation
@cocotb.coroutine
async def add_test(dut, A, B):
    """Test ADD operation with random inputs."""
    global pass_count
    global fail_count

    dut.opcode <= 0b0000  # Opcode for ADD
    dut.A <= A
    dut.B <= B
    await FallingEdge(dut.clk)
    expected = A + B
    if dut.Result.value == expected:
        print(f"ADD Test PASS: {A} + {B} = {dut.Result.value}")
        pass_count += 1
    else:
        print(f"ADD Test FAIL: {A} + {B} != {dut.Result.value}, expected {expected}")
        fail_count += 1

# Test subtraction operation
@cocotb.coroutine
async def sub_test(dut, A, B):
    """Test SUB operation with random inputs."""
    global pass_count
    global fail_count
    dut.opcode <= 0b0001  # Opcode for SUB
    dut.A <= A
    dut.B <= B
    await FallingEdge(dut.clk)
    if A >= B:
        expected = A - B
    else:
        expected = 512 + (A - B)
    if int(dut.Result.value) == int(expected):
        print(f"SUB Test PASS: {A} - {B} = {dut.Result.value}")
        pass_count += 1
    else:
        print(f"SUB Test FAIL: {A} - {B} != {int(dut.Result.value)}, expected {expected}")
        fail_count += 1

# Test AND operation
@cocotb.coroutine
async def AND_test(dut, A, B):
    """Test AND operation with random inputs."""
    global pass_count
    global fail_count
    dut.opcode <= 0b0010  # Opcode for AND
    dut.A <= A
    dut.B <= B
    await FallingEdge(dut.clk)
    expected = A & B
    if dut.Result.value == expected:
        print(f"AND Test PASS: {A} & {B} = {dut.Result.value}")
        pass_count += 1
    else:
        print(f"AND Test FAIL: {A} & {B} != {dut.Result.value}, expected {expected}")
        fail_count += 1

# Test OR operation
@cocotb.coroutine
async def or_test(dut, A, B):
    """Test OR operation with random inputs."""
    global pass_count
    global fail_count
    dut.opcode <= 0b0011  # Opcode for OR
    dut.A <= A
    dut.B <= B
    await FallingEdge(dut.clk)
    expected = A | B
    if dut.Result.value == expected:
        print(f"OR Test PASS: {A} | {B} = {dut.Result.value}")
        pass_count += 1
    else:
        print(f"OR Test FAIL: {A} | {B} != {dut.Result.value}, expected {expected}")
        fail_count += 1

# Test XOR operation
@cocotb.coroutine
async def xor_test(dut, A, B):
    """Test XOR operation with random inputs."""
    global pass_count
    global fail_count
    dut.opcode <= 0b0100  # Opcode for XOR
    dut.A <= A
    dut.B <= B
    await FallingEdge(dut.clk)
    expected = A ^ B
    if dut.Result.value == expected:
        print(f"XOR Test PASS: {A} ^ {B} = {dut.Result.value}")
        pass_count += 1
    else:
        print(f"XOR Test FAIL: {A} ^ {B} != {dut.Result.value}, expected {expected}")
        fail_count += 1

# Test default operation
@cocotb.coroutine
async def default_test(dut, A, B):
    """Test default operation with random inputs."""
    global pass_count
    global fail_count
    dut.opcode <= 0b1111  # Opcode for default operation
    dut.A <= A
    dut.B <= B
    await FallingEdge(dut.clk)
    expected = 0
    if dut.Result.value == expected:
        print(f"Default Test PASS: {A} ? {B} = {dut.Result.value}")
        pass_count += 1
    else:
        print(f"Default Test FAIL: {A} ? {B} != {dut.Result.value}, expected {expected}")
        fail_count += 1

@cocotb.test()
async def test_alu(dut):
    """Main test for ALU with random inputs."""
    await generate_clock(dut)
    await reset(dut)

    global pass_count
    global fail_count

    # Run tests with random inputs
    for _ in range(100):  # Run the test 5 times
        A = random.randint(0, 255)  # Random 8-bit value for A
        B = random.randint(0, 255)  # Random 8-bit value for B
        
        await add_test(dut, A, B)
        await sub_test(dut, A, B)
        await AND_test(dut, A, B)
        await or_test(dut, A, B)
        await xor_test(dut, A, B)
        await default_test(dut, A, B)

    print(f"NO. Pass = {pass_count}")
    print(f"NO. Fail = {fail_count}")
